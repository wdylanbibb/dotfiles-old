---------------------------------------------
-- Awesome theme which follows xrdb config --
--   by Yauhen Kirylau                    --
---------------------------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local xrdb = xresources.get_current_theme()
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local config_dir = gfs.get_configuration_dir()

-- inherit default theme
local theme = dofile(themes_path .. "default/theme.lua")
-- load vector assets' generators for this theme

theme.font = "FiraCode Nerd Font 8"

theme.bg_normal = "#282828"
theme.bg_focus = "#458588"
theme.bg_urgent = "#fb4934"
theme.bg_minimize = "#a89984"
theme.bg_systray = theme.bg_normal

theme.fg_normal = "#ebdbb2"
theme.fg_focus = theme.fg_normal
theme.fg_urgent = theme.fg_normal
theme.fg_minimize = theme.fg_normal

theme.useless_gap = dpi(2)
theme.border_normal = "#282828"
theme.border_focus = "#458588"

theme.taglist_fg_empty = "#928374"

theme.taglist_squares_sel = nil
theme.taglist_squares_unsel = nil

theme.wallpaper = themes_path .. "catppuccin-macchiato/background.png"

theme.lain_icons = config_dir .. "/lain/icons/layout/default/"

theme.layout_termfair = theme.lain_icons .. "termfair.png"
theme.layout_centerfair = theme.lain_icons .. "centerfair.png"
theme.layout_cascade = theme.lain_icons .. "cascade.png"
theme.layout_cascadetile = theme.lain_icons .. "cascadetile.png"
theme.layout_centerwork = theme.lain_icons .. "centerwork.png"
theme.layout_centerworkh = theme.lain_icons .. "centerworkh.png"

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
