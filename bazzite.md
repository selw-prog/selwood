# [Bazzite]((https://bazzite.gg/) )

Currently have dual boot configured while I migrate off of Windows.

## PC Specs
![specs](https://github.com/user-attachments/assets/8a3c8385-85db-4a5f-938d-40c2f02c2d4a)


## Install



## Apps

Here is what Bazzite [suggests to manage software](https://docs.bazzite.gg/Installing_and_Managing_Software/)

Flatpacks and Distrobox both make the $HOME folder available from the host to the sand box. Flatpacks and Distrobox have different $PATH variables than the host.

### FlatPaks

[Flatpak](https://docs.bazzite.gg/Installing_and_Managing_Software/Flatpak/) - Universal package format using a permissions-based model and should be used for most graphical applications. Parallell to Android or IOS apps.

```bash
flatpak install com.google.Chrome
flatpak install com.visualstudio.code
flatpak install org.kde.gcompris
flatpak install org.keepassxc.KeePassXC
flatpak install com.spotify.Client
flatpak install com.discordapp.Discord
```

#### Visual Studio Code

Run commands on the host from inside the sandbox using [Shell Integrated Terminal](https://github.com/flathub/com.visualstudio.code?tab=readme-ov-file#use-host-shell-in-the-integrated-terminal)

Support for [SDKs](https://github.com/flathub/com.visualstudio.code?tab=readme-ov-file#support-for-language-extension) on the host system
* helm TODO 📝
* kubectl TODO 📝
* Powershell TODO 📝
* Python TODO 📝

### Homebrew

[Homebrew](https://docs.bazzite.gg/Installing_and_Managing_Software/Homebrew/) - Install applications intended to run inside of the terminal (CLI/TUI).
Parallell to homebrew on Mac OS X.

```bash
brew install rclone
```

### Distrobox

[Distrobox](https://docs.bazzite.gg/Installing_and_Managing_Software/Distrobox/) - Access to most Linux package managers for software that do not support Flatpak and Homebrew and for use as development boxes.
Parallell to [WSL](https://learn.microsoft.com/en-us/windows/wsl/about).

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


### GOG

Used the [json](https://lutris.net/api/installers/gog-galaxy-windows?format=json) file from [lutris](https://lutris.net/games/gog-galaxy/).


### Epic Games

TODO 📝 I don't think i have an Epic Games account

### Riot Games

TODO 📝

### Emulators
