-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
-- config.colors = require("tokyonight.tokyonight_night")
config.color_scheme = "Tokyo Night Moon"
-- config.colors.background = "black"
-- config.window_background_opacity = 0.85
-- config.window_background_gradient = {
-- 	orientation = "Horizontal",
-- 	colors = {
-- 		"black",
-- 		"#732470",
-- 		"#4c7a5a",
-- 	},
-- }
config.window_padding = {
	left = 2,
	right = 2,
	top = 2,
	bottom = 2,
}
-- config.macos_window_background_blur = 10

config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 16.5

config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_max_width = 48
-- and finally, return the configuration to wezterm
return config
