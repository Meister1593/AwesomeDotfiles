--      ████████╗ ██████╗ ██████╗     ██████╗  █████╗ ███╗   ██╗███████╗██╗
--      ╚══██╔══╝██╔═══██╗██╔══██╗    ██╔══██╗██╔══██╗████╗  ██║██╔════╝██║
--         ██║   ██║   ██║██████╔╝    ██████╔╝███████║██╔██╗ ██║█████╗  ██║
--         ██║   ██║   ██║██╔═══╝     ██╔═══╝ ██╔══██║██║╚██╗██║██╔══╝  ██║
--         ██║   ╚██████╔╝██║         ██║     ██║  ██║██║ ╚████║███████╗███████╗
--         ╚═╝    ╚═════╝ ╚═╝         ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝

-- ===================================================================
-- Initialization
-- ===================================================================

local naughty = require("naughty")
local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local dpi = beautiful.xresources.apply_dpi

-- import widgets
local task_list = require("widgets.task-list")

-- define module table
local top_panel = {}


-- ===================================================================
-- Bar Creation
-- ===================================================================

-- Icon size - lower is bigger
local icon_size = 1

top_panel.create = function(s)
   local panel =
      awful.wibar(
      {
         screen = s,
         position = "top",
         ontop = true,
         height = beautiful.top_panel_height,
         width = s.geometry.width
      }
   )
   panel:setup {
      expand = "none",
      layout = wibox.layout.align.horizontal,
      task_list.create(s),
      require("widgets.calendar").create(s),
      {
         layout = wibox.layout.fixed.horizontal,
         wibox.layout.margin(wibox.widget.systray(), dpi(icon_size), dpi(icon_size), dpi(icon_size), dpi(icon_size)),
         awful.widget.keyboardlayout:new(),
         wibox.layout.margin(
            require("widgets.layout-box"),
            dpi(icon_size),
            dpi(icon_size),
            dpi(icon_size),
            dpi(icon_size)
         )
      }
   }

   -- ===================================================================
   -- Functionality
   -- ===================================================================

   -- hide panel when client is fullscreen
   local function change_panel_visibility(client)
      if client.screen == s then
         panel.ontop = not client.fullscreen
      end
   end

   -- connect panel visibility function to relevant signals
   client.connect_signal("property::fullscreen", change_panel_visibility)
   client.connect_signal("focus", change_panel_visibility)

   local last_focused_screen = awful.screen.focused()
   gears.timer {
      timeout = 2,
      call_now = true,
      autostart = true,
      callback = function()
         if last_focused_screen ~= awful.screen.focused() then
            wibox.widget.systray():set_screen(awful.screen.focused())
         end
         last_focused_screen = awful.screen.focused()
      end
   }
end

return top_panel
