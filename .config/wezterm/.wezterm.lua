-- WezTerm configuration file
--             \\
--     \\      (o>
--     (o>     //\ 
--    _(()_____V_/_____
--     ||      ||
--             ||

local wezterm = require 'wezterm'
local mux = wezterm.mux

local config = wezterm.config_builder()

-- Use powershell so we can use unix commands such as "ls" and "clear".
-- config.default_prog = { 'powershell.exe', '-NoExit', '-Command', 'fastfetch; Write-Host "`n"' }
config.default_prog = { 'powershell.exe' }
config.font = wezterm.font 'JetBrains Mono'
config.font_size = 12
config.color_scheme = 'Catppuccin Macchiato'
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_padding = {
  top = 0,
  right = 0,
  bottom = 0,
  left = 16
 }
config.exit_behavior = 'Hold'
config.exit_behavior_messaging = 'None'

-- Define the function that will handle window creation.
wezterm.on("gui-startup", function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
  local new_pane = pane:split({ direction = "Right", size = 0.5, args = { 'powershell.exe', '-Command', 'fastfetch' }})
  new_pane:split({ direction = "Top", size = 0.03, args = { 'powershell.exe', '-Command', 'fastfetch' }})
end)

return config