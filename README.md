# About
Thís is my arch linux + hyprland setup, and a guide to install
# 1. Must-have
## 1.1. Packages
- `ufw` (basic firewall)
- `firefox` (browser)
- `htop` (task manager)
- `alacritty` (terminal)
- [`paru`](https://github.com/Morganamilo/paru) or [`yay`](https://github.com/Jguer/yay) (AUR) (also make sure to enable [multilib](https://wiki.archlinux.org/title/Official_repositories#multilib))
- `neofetch`/[`uwufetch`](https://github.com/ad-oliviero/uwufetch) (rice)
- `flatpak` (for `bottles` and `obs-studio`)
- `nvim` (text editor)
- `swww` (wallpaper)
- `mako` (notifications)
- `rofi` (app launcher)
- `rofimoji` (emoji picker using rofi)
- `waybar` (task bar)
- `wlogout` (power selector)
- `ly` (CLI display manager)
- `hyprpaper` (screenshot)
- `hypridle` (idle daemon)
- `hyprlock` (lock screen)
- `xdg-desktop-portal-hyprland` (compositor support)
- `qt5ct`, `qt6ct` (Qt5/6 config tool)
- `pywal16`, `pywal-spicetify`, `pywal-discord`* (color schemes based on wallpaper)
- `mpv`, `feh` (video and image viewer)
- `ibus-daemon` (keyboard layout)
- `wl-clipboard`, `cliphist` (clipboard)
- `wpctl`, `brightnessctl` (volume and brightness control)
- `bluetui` (CLI bluetooth devices manager)

\* `pywal-discord` has been tested to work with Vencord and Vesktop
\* You will need to read more about `pywal-spicetify` if you use it. Basically, it will *apply color on the theme* spicetify is using, and it will not create a new theme

# 2. Quick guide
- Copy everything in `.config` folder into `/home/username/.config/`
- Edit the path `/home/username/` to your username accordingly, in all files 
- About the `wallpaper.sh` script: It will use `rofi` as a wallpaper picker, then use `pywal` to change the system's color schemes. Another function is to randomly pick a wallpaper
- About the `xdph.sh` script: [read here](https://wiki.hyprland.org/Useful-Utilities/xdg-desktop-portal-hyprland/#usage)

# 3. Troubleshoot and tips

## 3.0 "I forgot how to navigate Hyprland"
This will help during the first time you use Hyprland on your empty Arch
By default, the "super" key is your Windows key (the one next to Alt)
- `Win + Q`: open terminal
- `Win + E`: open file manager
- `Win + R`: open app launcher
- `Win + C`: close active window (the one with the cursor on it)
- `Win + M`: exit Hyprland and return to display manager
- `Win + 1->0`: change workspaces

[Default Hyprland config in case you need it](https://github.com/hyprwm/Hyprland/blob/main/example/hyprland.conf)

## 3.1 Cleanup unused dependencies
- [More about this on the Arch Wiki](https://wiki.archlinux.org/title/Pacman/Tips_and_tricks#Removing_unused_packages_(orphans))
```bash
sudo pacman -Qdtq | sudo pacman -Rns -
sudo pacman -Qqd | sudo pacman -Rsu - # deeper cleaning; this might delete some "certificates" that firefox needed, so whitelist it or reinstall it later
```
## 3.2 Bottles fix
[Bottles](usebottles.com) is a Wine wrapper, which is basically a Window emulator to run Windows apps on Linux
The following steps should fix some troubles like the Microsoft login screen, support obscure applications or "open-in-browser" popup
- Install dependencies: `dotnet48` `d3dcompiler_47` `wininet` `ierutil` `urlmon`
- Use the "debug" way to find out what's wrong: `flatpak run --command=bottles-cli com.usebottles.bottles run --help`. This should show every errors on the terminal
- Make sure to "nuke" the xdg-desktop-portal (read the `xdph.sh` part)

## 3.3 OBS Studio fix
- Install OBS through `flatpak` should solve all the problems: screen not found, drivers missing, etc.
- Make sure to "nuke" the xdg-desktop-portal (read the `xdph.sh` part)

## 3.4 Proton VPN uninstallation
- Proton VPN might break the wifi after uninstall
- Run the following commands then restart
```bash
nmcli c show --active
nmcli c delete pvpn-ipv6leak-protection
```

## 3.5 Dual-boot and the order of booting
- [Use `os-prober`](https://wiki.archlinux.org/title/GRUB#Detecting_other_operating_systems) to detect other OS like Windows
- About boot order: Edit inside `/boot/grub/grub.cfg`. Something like this:
```bash
### END 00_header ###

### BEGIN 10_linux ###
menuentry 'Arch Linux'...
...
### END 10_linux ###

### BEGIN os-prober ###
menuentry 'Window Boot Manager'...
...
### END os-prober ###
```
- Swap each sessions accordingly
- Better read more about it online

## 3.6 Access other operating systems' files on Arch
- You should use `nemo`, basically a file manager that supports that, however it might create some unnecessary QoL folders
- `libimobiledevice` will help access iOS through cables

# Afterwords
- An `install.sh` script might be made in the future. However it won't be able to cover 100% of the setup