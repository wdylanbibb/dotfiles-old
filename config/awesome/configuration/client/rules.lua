local awful = require("awful")
local gears = require("gears")
local client_keys = require("configuration.client.keys")
local client_buttons = require("configuration.client.buttons")
local title_bars = require("configuration.client.titlebars")
local beautiful = require("beautiful")

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
	-- All clients will match this rule.
	{
		rule = {},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = clientKeys,
			buttons = clientButtons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
		},
	},

	-- Add titlebars to normal clients
	{
		rule_any = {
			type = {
				"normal",
			},
		},
		-- properties = {
		-- 	titlebars_enabled = true,
		-- },
		callback = function(c)
			if awful.screen.focused().selected_tag.layout == awful.layout.suit.floating then
				awful.titlebar.show(c)
			else
				awful.titlebar.hide(c)
			end
		end,
	},

	-- -- Have awesome work better with KDE
	-- {
	-- 	rule_any = { type = { "dialog" }, class = { "kscreen_osd_service" } },
	-- 	properties = {
	-- 		titlebars_enabled = false,
	-- 		floating = true,
	-- 		placement = awful.placement.no_offscreen + awful.placement.restore,
	-- 		border_width = 0,
	-- 		-- Move popup to current tag (goes to tag 1 otherwise)
	-- 		callback = function(c)
	-- 			c:move_to_tag(awful.screen.focused().selected_tag)
	-- 		end,
	-- 	},
	-- },
	--
	-- -- Hacky way to have KDE Panel act normally with dynamic titlebars
	-- {
	-- 	rule = { type = "dock" },
	-- 	properties = {
	-- 		sticky = true,
	-- 		border_width = 0,
	-- 		titlebars_enabled = true,
	-- 		callback = function(c)
	-- 			awful.titlebar.hide(c)
	-- 		end,
	-- 	},
	-- },

	{
		rule = { type = "desktop" },
		properties = { sticky = true, border_width = 0, maximized = true, titlebars_enabled = false },
	},

	{
		rule = { class = "firefox", type = "utility" },
		properties = { sticky = true, border_width = 0 },
	},

	{
		rule = { class = "mullvad vpn" },
		properties = {
			titlebars_enabled = false,
			floating = true,
			placement = awful.placement.no_offscreen + awful.placement.restore,
		},
	},

	-- Set Firefox to always map on the tag named "2" on screen 1.
	-- { rule = { class = "Firefox" },
	--   properties = { screen = 1, tag = "2" } },
}
-- }}}
