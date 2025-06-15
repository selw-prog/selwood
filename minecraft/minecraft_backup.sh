#!/bin/bash

# Configuration
MC_DIR="/home/minecraft/server"        # Minecraft server directory
BACKUP_DIR="/home/minecraft/backups"      # Local backup directory
RCLONE_REMOTE="gdrive"               # rclone remote name (e.g., Google Drive)
RCLONE_PATH="minecraft_backups"      # Cloud storage folder
SERVICE_NAME="minecraft"             # systemd service name
BACKUP_NAME="Minecraft-$(date +%F_%H-%M-%S).tgz"  # Backup filename with timestamp
LOG_FILE="/home/minecraft/backups/backup.log"  # Log file for backup operations
MAX_BACKUPS=2                        # Number of backups to retain

# Ensure backup directory exists
mkdir -p "$BACKUP_DIR"

# Function to log messages
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

# Check if Minecraft directory exists
if [ ! -d "$MC_DIR" ]; then
    log "Error: Minecraft directory $MC_DIR does not exist."
    exit 1
fi

# Check if rclone is installed and configured
if ! command -v rclone &> /dev/null; then
    log "Error: rclone is not installed."
    exit 1
fi

# Check Google Drive for existing backups before upload
log "Checking existing backups in $RCLONE_REMOTE:$RCLONE_PATH..."
if sudo -u minecraft rclone ls "$RCLONE_REMOTE:$RCLONE_PATH" > "$BACKUP_DIR/pre_upload_check.txt" 2>&1; then
    log "Pre-upload check: Existing backups in Google Drive:"
    cat "$BACKUP_DIR/pre_upload_check.txt" >> "$LOG_FILE"
else
    log "Warning: Failed to list Google Drive contents. Proceeding with backup, but check rclone configuration."
fi
rm -f "$BACKUP_DIR/pre_upload_check.txt"

# Stop the Minecraft server
log "Stopping Minecraft server ($SERVICE_NAME)..."
if sudo systemctl stop "$SERVICE_NAME"; then
    log "Minecraft server stopped successfully."
else
    log "Error: Failed to stop Minecraft server."
    exit 1
fi
sleep 5  # Wait for the server to fully stop

# Create compressed backup
log "Creating backup: $BACKUP_DIR/$BACKUP_NAME"
if tar -czf "$BACKUP_DIR/$BACKUP_NAME" -C "$(dirname "$MC_DIR")" "$(basename "$MC_DIR")"; then
    log "Backup created successfully: $BACKUP_NAME"
else
    log "Error: Failed to create backup."
    sudo systemctl start "$SERVICE_NAME"
    exit 1
fi

# Start the Minecraft server
log "Starting Minecraft server ($SERVICE_NAME)..."
if sudo systemctl start "$SERVICE_NAME"; then
    log "Minecraft server started successfully."
else
    log "Error: Failed to start Minecraft server."
    exit 1
fi

# Upload backup to cloud storage
log "Uploading backup to $RCLONE_REMOTE:$RCLONE_PATH/$BACKUP_NAME..."
if sudo -u minecraft rclone copy "$BACKUP_DIR/$BACKUP_NAME" "$RCLONE_REMOTE:$RCLONE_PATH" --log-file "$LOG_FILE" --log-level INFO; then
    log "Backup uploaded successfully to $RCLONE_REMOTE:$RCLONE_PATH/$BACKUP_NAME"
else
    log "Error: Failed to upload backup to cloud storage."
    exit 1
fi

# Verify the backup exists in cloud storage
log "Verifying backup in cloud storage..."
if sudo -u minecraft rclone ls "$RCLONE_REMOTE:$RCLONE_PATH/$BACKUP_NAME" &> /dev/null; then
    log "Backup verified in cloud storage: $BACKUP_NAME"
    # Delete older backups (local and remote) to keep only the two most recent
    log "Deleting backups older than the two most recent..."
    # Local backups
    ls -t "$BACKUP_DIR"/Minecraft-*.tgz | tail -n +$((MAX_BACKUPS + 1)) | xargs -I {} rm -f {}
    log "Older local backups deleted. Kept two most recent."
    # Remote backups
    sudo -u minecraft rclone lsl "$RCLONE_REMOTE:$RCLONE_PATH" --include "Minecraft-*.tgz" | sort -r | tail -n +$((MAX_BACKUPS + 1)) | awk '{print $4}' | xargs -I {} sudo -u minecraft rclone delete "$RCLONE_REMOTE:$RCLONE_PATH/{}" --log-file "$LOG_FILE" --log-level INFO
    log "Older remote backups deleted. Kept two most recent."
else
    log "Error: Backup $BACKUP_NAME not found in cloud storage. Skipping deletion of older backups."
    exit 1
fi

log "Backup process completed successfully."
