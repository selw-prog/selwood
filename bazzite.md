# [Bazzite](https://bazzite.gg/)

Currently have dual boot configured while I migrate completely off of Windows.

## PC Specs
![specs](https://github.com/user-attachments/assets/70ed75e8-33d4-43b9-abd3-fc0ad0c6321d)


## Install

## Apps

Here is what Bazzite [suggests to manage software](https://docs.bazzite.gg/Installing_and_Managing_Software/)

Flatpacks and Distrobox both make the $HOME folder available from the host to the sand box. Flatpacks and Distrobox have different $PATH variables than the host.

### FlatPaks

[Flatpak](https://docs.bazzite.gg/Installing_and_Managing_Software/Flatpak/) - Universal package format using a permissions-based model and should be used for most graphical applications. Parallell to Android or IOS apps.

```bash
flatpak install com.google.Chrome
flatpak install org.kde.gcompris
flatpak install org.keepassxc.KeePassXC
flatpak install com.spotify.Client
flatpak install com.discordapp.Discord
flatpak install org.libreoffice.LibreOffice
flatpak install com.atlauncher.ATLauncher
flatpak install com.mikrotik.WinBox
flatpak install com.surfshark.Surfshark
flatpak install com.stremio.Stremio
flatpak install com.unity.UnityHub
flatpak install com.visualstudio.code
flatpak install org.blender.Blender
flatpak install --user https://flathub.org/repo/appstream/org.gimp.GIMP.flatpakref
```

### Homebrew

[Homebrew](https://docs.bazzite.gg/Installing_and_Managing_Software/Homebrew/) - Install applications intended to run inside of the terminal (CLI/TUI).
Parallell to homebrew on Mac OS X.

```bash
brew install rclone
```

### Distrobox

[Distrobox](https://docs.bazzite.gg/Installing_and_Managing_Software/Distrobox/) - Access to most Linux package managers for software that do not support Flatpak and Homebrew and for use as development boxes.
Parallell to [WSL](https://learn.microsoft.com/en-us/windows/wsl/about).

distrobox.ini
```bash
[deb-python]
image=debian:latest
home=/home/sean/deb-python
nvidia=true

[deb-pwsh]
image=debian:latest
home=/home/sean/deb-pwsh
nvidia=true
```

####

## Gaming

### Steam

* Enable All Steam Games
   > Steam > Settings > Compatibility 

### Lutris

#### Blizzard Games

* Installed Battle.net via Lutris
    > Add Game to Lutris > Search the Lutris website for installers > Search for Battle.net
* I have only been able to get Battle.net to launch when using Proton - Experimental as the runner.
    > Game > Configure > Runner options > Wine version > Proton - Experimental
* Ran into hangs when using runners besides Proton - Experimental including : 
    * Battle.net Update Agent went to sleep. Attempting to wake it up... (BLZBNTBNA00000005)
    * Updating Battle.net Update Agent... (45%)


SteamCMD can be used to download Proton - Experimental. 

```bash
ujust install-steamcmd
./.steam/linux32/steamcmd
login anonymous
app_update 1493710
quit
```

* Alternatively, you can go to your Steam library and download it - ensure you have Tools displayed and it should appear as an option. 
    * This download will also take place if you have a game's properties configured to use Proton - Experimental. 

### Game Development

* Currently I am exploring Unity. I have installed UnityHub and Visual Studio Code (see *FlatPaks* section). I am still working through tutorials.

### Azure Development

* I am using a Debian distrobox instance. Below are commands to install PowerShell and the Az (Azure) module.

```bash
sudo apt install powershell
sudo apt-get install -y wget
source /etc/os-release
wget -q https://packages.microsoft.com/config/debian/$VERSION_ID/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
sudo apt-get update
sudo apt-get install -y powershell
```

```pwsh
Install-Module -Name Az -Repository PSGallery 
Update-Module -Name Az -Force
Connect-AzAccount
```