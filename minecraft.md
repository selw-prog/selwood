# Minecraft Server

My goal is to host a vanilla Minecraft server on a Proxmox VM on my local network. I do not intend to have more than 1-3 players online at a given time. 
I generated most of the below using Grok.

## Recommended VM Specs

### 1. CPU
- **Cores**: 1-2 vCPUs
- **Type**: Modern CPU with strong single-core performance (e.g., Intel Xeon, AMD EPYC, Intel i3/i5, or AMD Ryzen)
- **Reason**: Minecraft is primarily single-threaded, so one strong core is sufficient. A second core helps with OS tasks and minor server processes (e.g., chunk loading).

### 2. RAM
- **Allocation**: 2-4 GB dedicated to the VM
  - **1-2 GB** for the Minecraft server process (set via `-Xmx1G -Xms1G` or `-Xmx2G -Xms1G`)
  - **1-2 GB** for the guest OS and Proxmox overhead
- **Reason**: A small server needs 1-2 GB for Minecraft. Extra RAM ensures the OS runs smoothly.

### 3. Storage
- **Size**: 10-20 GB SSD storage
  - **5-10 GB** for the Minecraft world, server files, and logs
  - Additional space for the OS and backups
- **Type**: SSD (NVMe preferred) for faster world loading and saving
- **Reason**: Small worlds generate smaller files. SSDs reduce lag during world saves and chunk generation.

### 4. Network
- **Bandwidth**: Stable internet with 5-10 Mbps upload/download
- **Network Interface**: VirtIO network driver for efficient networking
- **Port**: Open and forward port 25565 (TCP) for remote access
- **Reason**: Low player count requires minimal bandwidth, but stability is key to avoid lag.

### 5. Operating System
- **Recommended**: Ubuntu Server 22.04/24.04 LTS or Debian 12
- **Java Version**: OpenJDK 17 or 21 (required for recent Minecraft versions)
- **Reason**: Linux is lightweight and efficient for Proxmox VMs.

## Proxmox-Specific Considerations
- **Virtualization Type**: Use KVM with VirtIO drivers for disk and network
- **CPU Type**: Set to `host` to leverage the host CPU’s full performance
- **Ballooning**: Disable memory ballooning for consistent RAM allocation
- **Resource Allocation**: Avoid overcommitting CPU or RAM on the Proxmox host
- **Backup**: Configure Proxmox backups or manually back up the `world` folder

## Setup Steps
1. **Download Minecraft Server Software**
   - Download the latest `minecraft_server.<version>.jar` from [minecraft.net](https://minecraft.net).
   - Place it in a dedicated folder (e.g., `MinecraftServer`).

2. **Run the Server**
   - Start the server with:
     ```bash
     java -Xmx1G -Xms1G -jar minecraft_server.<version>.jar nogui
     ```
   - Adjust `-Xmx` and `-Xms` to `2G` if performance issues occur.

3. **Accept the EULA**
   - Open `eula.txt` in the server folder, change `eula=false` to `eula=true`, and save.

4. **Configure the Server**
   - Edit `server.properties` to set:
     - `gamemode` (e.g., `survival`)
     - `difficulty` (e.g., `normal`)
     - `max-players` (e.g., `3`)
     - `motd` (server description)
     - `pvp` (`true` or `false`)
     - `online-mode` (`true` for authenticated players)

5. **Network Setup**
   - **Local Play**: Connect using the VM’s local IP (e.g., `192.168.x.x:25565`) or `localhost`.
   - **Remote Play**:
     - Forward port 25565 (TCP) on your router to the VM’s local IP.
     - Share your public IP with players.
     - Ensure the firewall allows port 25565.

6. **Test the Server**
   - In Minecraft, add the server using the local or public IP and connect.

## Additional Notes
- **Performance**: These specs handle 1-3 players with minimal lag. Monitor CPU/RAM usage via Proxmox.
- **Scalability**: For more players, increase to 2 vCPUs and 4 GB RAM.
- **Backups**: Regularly back up the `world` folder to prevent data loss.
- **Troubleshooting**: Check the `logs` folder or the [Minecraft Wiki](https://minecraft.wiki/) for help.

For detailed setup or optimization steps, consult the official Minecraft documentation or request further assistance.

## Exposing Server Externally

I have a CGNAT IP so simple port forwarding is not a solution. I could host the server in a public cloud but I'd prefer not to introduce cost to this.
I found some software called [playit](https://playit.gg/) and installed that on my VM. Their free tier seems OK at this time. Configuration of this software is simple.