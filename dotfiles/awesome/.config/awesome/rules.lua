--      ██████╗ ██╗   ██╗██╗     ███████╗███████╗
--      ██╔══██╗██║   ██║██║     ██╔════╝██╔════╝
--      ██████╔╝██║   ██║██║     █████╗  ███████╗
--      ██╔══██╗██║   ██║██║     ██╔══╝  ╚════██║
--      ██║  ██║╚██████╔╝███████╗███████╗███████║
--      ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚══════╝╚══════╝
-- ===================================================================
-- Initialization
-- ===================================================================
local awful = require("awful")
local beautiful = require("beautiful")

-- define screen height and width
local screen_height = awful.screen.focused().geometry.height
local screen_width = awful.screen.focused().geometry.width

-- define module table
local rules = {}

-- ===================================================================
-- Rules
-- ===================================================================

-- return a table of client rules including provided keys / buttons
function rules.create(clientkeys, clientbuttons)
    local rofi_rule = {}

    rofi_rule = {
        rule_any = {name = {"rofi"}},
        properties = {
            maximized = true,
            floating = true,
            titlebars_enabled = false
        }
    }
    return {
        {
            -- Rule for any client that aren't explicitly configured
            rule = {},
            properties = {
                titlebars_enabled = beautiful.titlebars_enabled,
                border_width = beautiful.border_width,
                border_color = beautiful.border_normal,
                focus = awful.client.focus.filter,
                raise = true,
                keys = clientkeys,
                buttons = clientbuttons,
                screen = awful.screen.preferred,
                placement = awful.placement.centered,
                maximized = false,
                maximized_vertical = false,
                maximized_horizontal = false
            }
        },
        {
            -- Floating clients.
            rule_any = {
                instance = {"DTA", "copyq"},
                class = {"Nm-connection-editor"},
                name = {
                    "Event Tester",
                    "Steam Guard - Computer Authorization Required"
                },
                role = {"pop-up", "GtkFileChooserDialog"},
                type = {"dialog"}
            },
            properties = {floating = true}
        },
	{
	    rule_any = {class = {"Steam"}},
	    properties = {screen = 1, tag = "6", switchtotag = true}
	},
	{
            rule_any = {class = {"steam_app_.*"}},
            properties = {screen = 1, tag = "6", fullscreen = true, switchtotag = true}
        }, 
	{
	    rule_any = {class = {"discord"}},
	    properties = {tag = "5"}
	},
	-- "Switch to tag"
        {
            rule_any = {
                class = {"chromium.*", "firefox"},
                instance = {"Navigator"}
            },
            properties = {switchtotag = true}
        }, -- rofi rule determined above
        rofi_rule, -- File chooser dialog
        {
            rule_any = {role = {"GtkFileChooserDialog"}},
            properties = {
                floating = true,
                width = screen_width * 0.55,
                height = screen_height * 0.65
            }
        }, -- Pavucontrol & Bluetooth Devices
        {
            rule_any = {class = {"Pavucontrol"}, name = {"Bluetooth Devices"}},
            properties = {
                floating = true,
                width = screen_width * 0.55,
                height = screen_height * 0.45
            }
        }
    }
end

-- return module table
return rules
