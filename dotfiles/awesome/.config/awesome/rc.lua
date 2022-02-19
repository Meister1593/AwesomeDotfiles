--       █████╗ ██╗    ██╗███████╗███████╗ ██████╗ ███╗   ███╗███████╗
--      ██╔══██╗██║    ██║██╔════╝██╔════╝██╔═══██╗████╗ ████║██╔════╝
--      ███████║██║ █╗ ██║█████╗  ███████╗██║   ██║██╔████╔██║█████╗
--      ██╔══██║██║███╗██║██╔══╝  ╚════██║██║   ██║██║╚██╔╝██║██╔══╝
--      ██║  ██║╚███╔███╔╝███████╗███████║╚██████╔╝██║ ╚═╝ ██║███████╗
--      ╚═╝  ╚═╝ ╚══╝╚══╝ ╚══════╝╚══════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
--local sharedtags = require("sharedtags")

-- ===================================================================

-- User Configuration
-- ===================================================================

local themes = {
   "pastel", -- 1
   "mirage" -- 2
}

-- change this number to use the corresponding theme
local theme = themes[1]
local theme_config_dir = gears.filesystem.get_configuration_dir() .. "/configuration/" .. theme .. "/"

-- ===================================================================
-- Initialization
-- ===================================================================

-- Import notification appearance
require("components.notifications")

-- Autostart specified apps
local apps = require("apps")
apps.autostart()

-- Import theme
local beautiful = require("beautiful")
beautiful.init(gears.filesystem.get_configuration_dir() .. "themes/" .. theme .. "-theme.lua")

-- Initialize theme
local selected_theme = require(theme)
selected_theme.initialize()

-- Import Keybinds
local keys = require("keys")
root.keys(keys.globalkeys)
root.buttons(keys.desktopbuttons)

-- Import rules
local create_rules = require("rules").create
awful.rules.rules = create_rules(keys.clientkeys, keys.clientbuttons)

-- ===================================================================
-- Set Up Screen & Connect Signals
-- ===================================================================

-- Define layouts
awful.layout.layouts = {
   awful.layout.suit.tile,
   awful.layout.suit.floating,
   awful.layout.suit.max
}

-- remove gaps if layout is set to max
tag.connect_signal(
   "property::layout",
   function(t)
      local current_layout = awful.tag.getproperty(t, "layout")
      if (current_layout == awful.layout.suit.max) then
         t.gap = 0
      else
         t.gap = beautiful.useless_gap
      end
   end
)

-- Signal function to execute when a new client appears.
client.connect_signal(
   "manage",
   function(c)
      -- Set the window as a slave (put it at the end of others instead of setting it as master)
      if not awesome.startup then
         awful.client.setslave(c)
      end

      if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
         -- Prevent clients from being unreachable after screen count changes.
         awful.placement.no_offscreen(c)
      end
   end
)

client.connect_signal("property::fullscreen", function(c)
  if c.fullscreen then
    gears.timer.delayed_call(function()
      if c.valid then
        c:geometry(c.screen.geometry)
      end
    end)
  end
end)

-- ===================================================================
-- Client Focusing
-- ===================================================================

-- Autofocus a new client when previously focused one is closed
require("awful.autofocus")

-- Focus clients under mouse
--client.connect_signal("mouse::enter", function(c)
--   c:emit_signal("request::activate", "mouse_enter", {raise = false})
--end)

-- ===================================================================
-- Screen Change Functions (ie multi monitor)
-- ===================================================================

-- Reload config when screen geometry changes
screen.connect_signal("property::geometry", awesome.restart)

-- ===================================================================
-- Garbage collection (allows for lower memory consumption)
-- ===================================================================

collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)
