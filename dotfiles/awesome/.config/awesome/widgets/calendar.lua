require("lualib_bundle");
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["4"] = 1,["5"] = 2,["6"] = 3,["7"] = 4,["8"] = 6,["9"] = 7,["10"] = 9,["11"] = 10,["12"] = 10,["13"] = 10,["14"] = 10,["15"] = 14,["16"] = 15,["17"] = 10,["18"] = 10,["19"] = 10,["20"] = 9,["21"] = 9,["22"] = 22,["23"] = 23,["24"] = 22,["25"] = 26,["26"] = 58,["27"] = 60,["28"] = 6});
local ____exports = {}
local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
function ____exports.create(screen)
    local clockWidget = wibox.widget.textclock(("<span font='" .. beautiful.title_font) .. "'>%H:%M:%S</span>", 1, "Europe/Samara")
    awful.tooltip(
        {
            objects = {clockWidget},
            timeout = 1,
            shape = nil,
            timer_function = function(self)
                return os.date("The date today is %B %d, %Y.")
            end,
            margin_leftright = beautiful.xresources.apply_dpi(8),
            margin_topbottom = beautiful.xresources.apply_dpi(8)
        }
    )
    local function calShape(cr, width, height)
        return gears.shape.partially_rounded_rect(cr, width, height, false, false, true, true, 12)
    end
    local monthCalendar = awful.widget.calendar_popup.month({screen = screen, start_sunday = false, spacing = 10, font = beautiful.title_font, long_weekdays = true, margin = 0, style_month = {border_width = 0, shape = calShape, padding = 25}, style_header = {border_width = 0, bg_color = "#00000000"}, style_weekday = {border_width = 0, bg_color = "#00000000"}, style_normal = {border_width = 0, bg_color = "#00000000"}, style_focus = {border_width = 0, bg_color = "#8AB4F8"}})
    monthCalendar:attach(clockWidget, "tc", {on_pressed = true, on_hover = false})
    return clockWidget
end
return ____exports
