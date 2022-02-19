# AwesomeDotfiles
My dotfiles that i use daily because no other WM or DE provides such experience 

Most of the awesomewm dotfiles are based on https://github.com/WillPower3309/awesome-dotfiles dotfiles, which i'm glad he did them like so. Also big thanks for beatiful rofi themes to https://github.com/adi1090x/rofi devs

I didn't like how keys were placed and it lacked some programs i needed, so i modified it a bit, added several keys, added rules for my go-to programs and games to place on certain workspaces

Must-have dependencies:
1. Terminal: `kitty`
2. Lock: `i3lock-color + xidlehook` (xidlehook is currently not maintained and sadly won't be (https://github.com/jD91mZM2/xidlehook/issues/72), needs to be replaced)
3. Program Launcher: `rofi` (might need additional dependencies)
4. Screenshots: `flameshot`
5. File Manager: `caja`
6. Volume Control: `pasystray`
7. Compositor: `picom`
8. Polkit agent: `polkit-gnome-authentication-agent-1` (depends on the distro packages, look for yourself to find one)
9. Network Applet: `nm-applet`

Optional Dependencies (but are used by default in these dotfiles):
1. Calculator: `gnome-calculator`
2. Bluetooth Manager: `blueman`
3. Gif Maker: `peek`
4. Caffeine (to prevent appearning of lock screen on idle): `caffeine`
5. Battery info: `cbatticon`
6. Bluetooth media control: `mpris-proxy` (depends  on distro, look for yourself)
7. Tearing prevention (on AMD): `xrandr` (adjust your ports in `apps.lua`)
8. Kdeconnect indicator: flatpak `com.github.bajoja.indicator-kdeconnect`
9. Noise supression and audio effects: `easyeffects`
10. Audio effects, and scripts + crossfeed: `jamesdsp`

Basic installation (using GNU Stow)
1. Open terminal and type all next steps in it
2. `git clone https://github.com/Meister1593/AwesomeDotfiles.git .dotfiles` in a home folder
3. `cd .dotfiles/dotfiles`
4. `stow -nvt ~ *` and if it doesn't report error at the end (`WARNING: in simulation mode so not modifying filesystem.` is fine), then proceed to the next step. In case it reports something like - `path is not found`, then you might need to create these paths manually (for example, `~/Documents/Code/Shell/Scripts`)
5. `stow -vt ~ *` and it is done now
6. In case you want to modify arrangement of these dotfiles (not the contents, it is fine to change them when they are symlinked), it is highly advised to first unlink all files (`stow -Dvt ~ *` in `~/.dotfiles/dotfiles`) to prevent dangling symlinks.

After installation, you can log into AwesomeWM desktop, and if all went well, you won't have any errors. In case you have, you can open terminal through default awesomewm keybinds and then reload it (`Ctrl + Meta + R` is default keybind to reload awesome)


TODO:
  1. Move away from Breeze-Dark theme for gtk and qt for long
  2. Submodule rofi theme to proper git repository
  3. Add proper list of dependencies (it is quite big) and remove all unnecessary stuff that isn't needed (mirage theme?)
  4. Cleanup some .xinitrc, .profile etc files in case they are underutilised
  5. Move requried scripts for awesomewm to function into awesomewm folder instead of documents
  6. Started typescript-to-lua transisiton (calendar) should be either completed, or reverted back to normal Lua
