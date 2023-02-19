local wezterm = require("wezterm")
local act = wezterm.action

local function is_vi_process(pane)
	return pane:get_foreground_process_name():find("n?vim") ~= nil
end

local function conditional_activate_pane(window, pane, pane_direction, vim_direction)
	if is_vi_process(pane) then
		window:perform_action(wezterm.action.SendKey({ key = vim_direction, mods = "ALT" }), pane)
	else
		window:perform_action(wezterm.action.ActivatePaneDirection(pane_direction), pane)
	end
end

wezterm.on("ActivatePaneDirection-right", function(window, pane)
	conditional_activate_pane(window, pane, "Right", "l")
end)

wezterm.on("ActivatePaneDirection-left", function(window, pane)
	conditional_activate_pane(window, pane, "Left", "h")
end)

wezterm.on("ActivatePaneDirection-up", function(window, pane)
	conditional_activate_pane(window, pane, "Up", "k")
end)

wezterm.on("ActivatePaneDirection-down", function(window, pane)
	conditional_activate_pane(window, pane, "Down", "j")
end)

local color_scheme = "Catppuccin Macchiato" -- "OneDark (base16)"

local colors = wezterm.color.get_builtin_schemes()[color_scheme]
local white = 1
local red = 2
local green = 3
local yellow = 4
local blue = 5
local pink = 6
local teal = 7
local black = 8

local function get_process(tab)
	local process_icons = {
		["nvim"] = {
			{ Foreground = { Color = colors.ansi[green] } },
			{ Text = wezterm.nerdfonts.custom_vim },
		},
		["vim"] = {
			{ Foreground = { Color = colors.ansi[green] } },
			{ Text = wezterm.nerdfonts.dev_vim },
		},
		["zsh"] = {
			{ Foreground = { Color = colors.ansi[pink] } },
			{ Text = wezterm.nerdfonts.dev_terminal },
		},
		["fish"] = {
			{ Foreground = { Color = colors.ansi[pink] } },
			{ Text = wezterm.nerdfonts.mdi_fish },
		},
		["cargo"] = {
			{ Foreground = { Color = colors.ansi[pink] } },
			{ Text = wezterm.nerdfonts.dev_rust },
		},
		["transmission-cli"] = {
			{ Foreground = { Color = colors.ansi[red] } },
			{ Text = wezterm.nerdfonts.fa_cloud_download },
		},
		["bluetoothctl"] = {
			{ Foreground = { Color = colors.ansi[blue] } },
			{ Text = wezterm.nerdfonts.fa_bluetooth },
		},
	}

	local process_name = string.gsub(tab.active_pane.foreground_process_name, "(.*[/\\])(.*)", "%2")

	return wezterm.format(
		process_icons[process_name]
			or { { Foreground = { Color = colors.ansi[blue] } }, { Text = string.format("[%s]", process_name) } }
	)
end

local function get_current_working_dir(tab)
	local current_dir = tab.active_pane.current_working_dir
	local HOME_DIR = string.format("file://%s%s", wezterm.hostname(), os.getenv("HOME") .. "/")

	return current_dir == HOME_DIR and "   ~"
		or string.format("   %s", string.gsub(current_dir, "(.*[/\\])(.*)", "%2"))
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	return wezterm.format({
		{ Attribute = { Intensity = "Half" } },
		{ Text = string.format(" %s  ", tab.tab_index + 1) },
		"ResetAttributes",
		{ Text = get_process(tab) },
		{ Text = " " },
		{ Text = get_current_working_dir(tab) },
		{ Foreground = { Color = colors.background } },
		{ Text = "  ▕" },
	})
end)

wezterm.on("update-right-status", function(window, pane)
	window:set_right_status(wezterm.format({
		{ Attribute = { Intensity = "Bold" } },
		{ Text = wezterm.nerdfonts.oct_clock .. wezterm.strftime("  %A, %d %B %Y %I:%M %p") },
	}))
end)

wezterm.on("format-window-title", function(tab, pane, tabs, panes, config)
	return "Wezterm"
end)

return {
	color_scheme = color_scheme,
	-- font = wezterm.font("cozette"),
	-- font_size = 7,
	-- font_rules = {
	-- 	{
	-- 		italic = true,
	-- 		font = wezterm.font({
	-- 			family = "scientifica",
	-- 			style = "Italic",
	-- 		}),
	-- 	},
	-- },
	font = wezterm.font("FiraCode Nerd Font"),
	font_size = 10,
	font_rules = {
		{
			italic = true,
			intensity = "Normal",
			font = wezterm.font({
				family = "VictorMono Nerd Font",
				weight = "Medium",
				style = "Italic",
			}),
		},
		{
			italic = true,
			intensity = "Bold",
			font = wezterm.font({
				family = "VictorMono Nerd Font",
				weight = "Bold",
				style = "Italic",
			}),
		},
	},
	window_background_opacity = 0.9,
	-- background = {
	-- 	{
	-- 		source = { File = "/home/wdbibb/.config/wezterm/images/waves.png" },
	-- 		hsb = {
	-- 			brightness = 0.1,
	-- 		},
	-- 	},
	-- },
	use_fancy_tab_bar = false,
	tab_bar_at_bottom = true,
	tab_max_width = 50,
	window_padding = {
		left = "1cell",
		right = "1cell",
		top = "0cell",
		bottom = "0cell",
	},
	keys = {
		{ key = [[\]], mods = "ALT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{
			key = [[|]],
			mods = "ALT|SHIFT",
			action = act.SplitPane({ top_level = true, direction = "Right", size = { Percent = 50 } }),
		},
		{ key = [[-]], mods = "ALT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{
			key = [[_]],
			mods = "ALT|SHIFT",
			action = act.SplitPane({ top_level = true, direction = "Down", size = { Percent = 50 } }),
		},
		{ key = "n", mods = "ALT", action = act.SpawnTab("CurrentPaneDomain") },
		{ key = "Q", mods = "ALT", action = act.CloseCurrentTab({ confirm = false }) },
		{ key = "q", mods = "ALT", action = act.CloseCurrentPane({ confirm = false }) },
		{ key = "z", mods = "ALT", action = act.TogglePaneZoomState },
		{ key = "F11", mods = "", action = act.ToggleFullScreen },
		{ key = "h", mods = "ALT|SHIFT", action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "j", mods = "ALT|SHIFT", action = act.AdjustPaneSize({ "Down", 1 }) },
		{ key = "k", mods = "ALT|SHIFT", action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "l", mods = "ALT|SHIFT", action = act.AdjustPaneSize({ "Right", 1 }) },

		{ key = "h", mods = "ALT", action = act.EmitEvent("ActivatePaneDirection-left") },
		{ key = "j", mods = "ALT", action = act.EmitEvent("ActivatePaneDirection-down") },
		{ key = "k", mods = "ALT", action = act.EmitEvent("ActivatePaneDirection-up") },
		{ key = "l", mods = "ALT", action = act.EmitEvent("ActivatePaneDirection-right") },

		{ key = "[", mods = "ALT", action = act.ActivateTabRelative(-1) },
		{ key = "]", mods = "ALT", action = act.ActivateTabRelative(1) },
		{ key = "{", mods = "SHIFT|ALT", action = act.MoveTabRelative(-1) },
		{ key = "}", mods = "SHIFT|ALT", action = act.MoveTabRelative(1) },
		{ key = "v", mods = "ALT", action = act.ActivateCopyMode },
		{ key = "c", mods = "CTRL|SHIFT", action = act.CopyTo("Clipboard") },
		{ key = "v", mods = "CTRL|SHIFT", action = act.PasteFrom("Clipboard") },
		{ key = "=", mods = "CTRL", action = act.IncreaseFontSize },
		{ key = "-", mods = "CTRL", action = act.DecreaseFontSize },
		{ key = "1", mods = "ALT", action = act.ActivateTab(0) },
		{ key = "2", mods = "ALT", action = act.ActivateTab(1) },
		{ key = "3", mods = "ALT", action = act.ActivateTab(2) },
		{ key = "4", mods = "ALT", action = act.ActivateTab(3) },
		{ key = "5", mods = "ALT", action = act.ActivateTab(4) },
		{ key = "6", mods = "ALT", action = act.ActivateTab(5) },
		{ key = "7", mods = "ALT", action = act.ActivateTab(6) },
		{ key = "8", mods = "ALT", action = act.ActivateTab(7) },
		{ key = "9", mods = "ALT", action = act.ActivateTab(8) },
	},
	pane_focus_follows_mouse = true,
	colors = {
		tab_bar = {
			background = colors.background,
			active_tab = {
				bg_color = "none",
				fg_color = colors.ansi[black],
				intensity = "Bold",
				underline = "None",
				italic = false,
				strikethrough = false,
			},
			inactive_tab = {
				bg_color = colors.cursor_fg,
				fg_color = colors.brights[white],
			},
			inactive_tab_hover = {
				bg_color = colors.cursor_bg,
				fg_color = colors.brights[black],
			},
			new_tab = {
				bg_color = colors.cursor_fg,
				fg_color = colors.brights[black],
			},
			new_tab_hover = {
				bg_color = colors.cursor_fg,
				fg_color = colors.brights[black],
			},
		},
	},
	hyperlink_rules = {
		-- Linkify things that look like URLs and the host has a TLD name.
		-- Compiled-in default. Used if you don't specify any hyperlink_rules.
		-- https://www.google.com
		{
			regex = "\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b",
			format = "$0",
		},

		-- linkify email addresses
		-- Compiled-in default. Used if you don't specify any hyperlink_rules.
		{
			regex = [[\b\w+@[\w-]+(\.[\w-]+)+\b]],
			format = "mailto:$0",
		},

		-- file:// URI
		-- Compiled-in default. Used if you don't specify any hyperlink_rules.
		{
			regex = [[\bfile://\S*\b]],
			format = "$0",
		},

		-- Linkify things that look like URLs with numeric addresses as hosts.
		-- E.g. http://127.0.0.1:8000 for a local development server,
		-- or http://192.168.1.1 for the web interface of many routers.
		{
			regex = [[\b\w+://(?:[\d]{1,3}\.){3}[\d]{1,3}\S*\b]],
			format = "$0",
		},

		-- Make username/project paths clickable. This implies paths like the following are for GitHub.
		-- ( "nvim-treesitter/nvim-treesitter" | wbthomason/packer.nvim | wez/wezterm | "wez/wezterm.git" )
		-- As long as a full URL hyperlink regex exists above this it should not match a full URL to
		-- GitHub or GitLab / BitBucket (i.e. https://gitlab.com/user/project.git is still a whole clickable URL)
		{
			regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
			format = "https://www.github.com/$1/$3",
		},
	},
}
