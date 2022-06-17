# UPDATE FOR ANYONE WILLING TO USE THESE DOTFILES
I found the one setup that worked for me and it was Gnome + [Material Shell](https://github.com/material-shell/material-shell).

If you are willing to try out these dotfiles, i highly recommend to try using Material Shell first.

They do support Wayland, have very low entry threshold and works quite well. 

Only thing you will miss in that case is separate screen workspaces (one will be pinned on other monitors). 

But you will be rewarded with things like a persistent desktop, where you can have application launchers in workspaces where they were left.

In any case, i left this notice just for people to know that there is an actual alternative for this.

# AwesomeDotfiles
My dotfiles that i use daily because no other WM or DE provides such experience.

## Description
Most of the awesomewm dotfiles are based on https://github.com/WillPower3309/awesome-dotfiles dotfiles, which i'm glad he did them like so. Also big thanks for beatiful rofi themes to https://github.com/adi1090x/rofi devs.

I didn't like how keys were placed and it lacked some programs i needed, so i modified it a bit, added several keys, added rules for my go-to programs and games to place on certain workspaces.

## Confitubtion
Feel free to open issues you have  encountered with installing or using these dotfiles.

## Mandatory dependencies
1. Terminal: `kitty`
2. Lock: `i3lock-color` and `xidlehook` (xidlehook is currently not maintained and sadly won't be (https://github.com/jD91mZM2/xidlehook/issues/72), needs to be replaced)
3. Program Launcher: `rofi` (might need additional dependencies)
4. Screenshots: `flameshot`
5. File Manager: `caja`
6. Volume Control: `pasystray`
7. Compositor: `picom`
8. Polkit agent: `polkit-gnome-authentication-agent-1` (depends on the distro packages, look for yourself to find one)
9. Network Applet: `nm-applet`
10. Task manager: `gnome-system-monitor`
11. Background: `feh` and `imagemagick`

## Optional Dependencies (but are used by default in these dotfiles):
1. Calculator: `gnome-calculator`
2. Bluetooth Manager: `blueman`
3. Gif Maker: `peek`
4. Caffeine (to prevent appearning of lock screen on idle): `caffeine`
5. Battery info: `cbatticon`
6. Bluetooth media control: `mpris-proxy` (depends on distro, look for yourself)
7. Tearing prevention (on AMD): `xrandr` (adjust your video ports in `apps.lua`)
8. Kdeconnect indicator: user flatpak `com.github.bajoja.indicator-kdeconnect`
9. Noise supression and audio effects: `easyeffects`
10. Audio effects, and audio scripts + crossfeed: `jamesdsp`

## Basic installation (using GNU Stow)
1. Install GNU Stow for your distro
2. Open terminal and type all next steps in it.
3. `git clone https://github.com/Meister1593/AwesomeDotfiles.git .dotfiles` in a home folder.
4. `cd .dotfiles/dotfiles`.
5. `stow -nvt ~ *` and if it doesn't report error at the end (`WARNING: in simulation mode so not modifying filesystem.` is fine), then proceed to the next step. In case it reports something like - `path is not found`, then you might need to create these paths manually (for example, `~/Documents/Code/Shell/Scripts`)
6. `stow -vt ~ *` and it is done now.
7. In case you want to modify arrangement of these dotfiles (not the contents, it is fine to change them when they are symlinked), it is highly advised to first unlink all files (`stow -Dvt ~ *` in `~/.dotfiles/dotfiles`) to prevent dangling symlinks.

After installation, you can log into AwesomeWM desktop, and if all went well, you won't have any errors. 

In case you have any errors, you can open terminal (`Super + Return`), fix the error and then reload it (`Ctrl + Super + R` is default keybind to reload awesome).

To check current configured keys, press `Ctrl + Super + H`.

## Additional configuration
### Layout switching
By default, there is switching layout between us and ru locales.

If you want to change it (or remove it completely), look at first autostart lines in `apps.lua` and find xkb-related command.

From there you can configure your kb layouts.
### Wallpapers
To change wallpaper, you need to go to `~/.dotfiles/dotfiles/awesome/.config/awesome/wallpaper` and replace either `pastel_wallpaper` or `pastel_lock_wallpaper` with desired wallpaper
### Scroll with middle mouse
By default, dotfiles will load script that can make your mouse use scroll button as way to scroll way faster and in 2 dimensions, using entire mouse movements

It targets only handful of mouses (that i used personally) and only a handful of games (to disable this behaviour of scrolling in them), so your mouse will unlikely to be able to do this by default.

To enable this behaviour, you can check out your mouse name with `xinput` (actual mouse, not consumers or additional input devices) and then add to the array of the devices in the script your mouse

## Keybinds for these awesomewm dotfiles 
![image](https://user-images.githubusercontent.com/7141787/154796761-5a0e1af8-aaad-4908-9904-112d0b9034a3.png)

## TODO
  1. Move away from Breeze-Dark theme for gtk and qt for long.
  2. Submodule rofi theme to proper git repository.
  3. Remove all unnecessary stuff that isn't needed in awesome (mirage theme?).
  4. Cleanup some .xinitrc, .profile etc files in case they are underutilised.
  5. Move requried scripts for awesomewm to function into awesomewm folder instead of documents.
  6. Started typescript-to-lua transisiton (calendar) should be either completed, or reverted back to normal Lua.
