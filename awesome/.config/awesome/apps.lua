--       █████╗ ██████╗ ██████╗ ███████╗
--      ██╔══██╗██╔══██╗██╔══██╗██╔════╝
--      ███████║██████╔╝██████╔╝███████╗
--      ██╔══██║██╔═══╝ ██╔═══╝ ╚════██║
--      ██║  ██║██║     ██║     ███████║
--      ╚═╝  ╚═╝╚═╝     ╚═╝     ╚══════╝
-- ===================================================================
-- Initialization
-- ===================================================================
local awful = require("awful")
local gears = require("gears")

-- define module table
local apps = {}
local scripts_loc = os.getenv("HOME") .. "/Documents/Code/Shell/Scripts/"
local wallpaper_dir = gears.filesystem.get_configuration_dir() .. "wallpaper"
local wallpaper = wallpaper_dir .. "/pastel_lock_wallpaper"

-- ===================================================================
-- App Declarations
-- ===================================================================

-- define default apps
apps.default = {
    browser = "xdg-open about:newtab",
    terminal = "kitty",
    lock = "bash -c 'xkb-switch -s us && xidlehook-client --socket /tmp/xidlehook.socket control --action trigger --timer 0'",
    launcher = os.getenv("HOME") .. "/.config/rofi/launchers/colorful/launcher.sh",
    screenshot = "flameshot gui",
    screenshot_screen = "flameshot screen -c",
    gif_maker = "peek",
    filebrowser = "caja",
    taskmanager = "gnome-system-monitor",
    calculator = "gnome-calculator",
    volume_control = "pasystray",
    compositor = "picom",
    polkit = "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1",
    network_applet = "nm-applet",
    audio_control = scripts_loc .. "/control_audio_dbus.sh"
}

require("naughty").notify({text=wallpaper})
-- List of apps to start once on start-up
local run_on_start_up = {
    -- Polkit daemon startup
    apps.default.polkit,
    -- Keyboard layouts
    "setxkbmap -layout us,ru -option 'grp:win_space_toggle'",
    -- Run compositor/decorator
    apps.default.compositor,
    -- Kdeconnect daemon + applet
    -- "/usr/lib/kdeconnectd",
    -- "kdeconnect-indicator",
    -- Blueman applet
    "blueman-applet",
    -- Caffeine anti-lock
    "caffeine",
    -- My own move-mouse stuff
    scripts_loc .. "/dowhilerunning.sh",
    -- Volume control tray
    apps.default.volume_control,
    -- Autolock screen after 5 min  + disable screens after 30 more secs
    scripts_loc .. "/screen_lock_xidlehook.sh " .. wallpaper,
    -- Applet for network
    apps.default.network_applet,
    -- Battery icon
    "cbatticon",
    --"pipewire",
    --"pipewire-pulse",
    "mpris-proxy",
    "xrandr --output DisplayPort-1 --set TearFree on",
    "xrandr --output DisplayPort-2 --set TearFree on",
    --"snixembed",
    "/usr/bin/flatpak --user run com.github.bajoja.indicator-kdeconnect",
    "easyeffects --gapplication-service",
    "jamesdsp -t"
}

-- ===================================================================
-- Functionality
-- ===================================================================

-- Run all the apps listed in run_on_start_up
function apps.autostart()
    for _, app in ipairs(run_on_start_up) do
        local findme = app
        local firstspace = app:find(" ")
        if firstspace then
            findme = app:sub(0, firstspace - 1)
        end
        awful.spawn.with_shell(string.format("ps aux | grep -v grep | grep %s > /dev/null || (%s)", findme, app), false)
    end
end

return apps
