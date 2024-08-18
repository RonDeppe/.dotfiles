-- WezTerm configuration file
--             \\
--     \\      (o>
--     (o>     //\ 
--    _(()_____V_/_____
--     ||      ||
--             ||

local wezterm = require 'wezterm'
local mux = wezterm.mux
-- Make sure to install the newest version of powershell and not the version that comes with windows.
local POWERSHELL = 'C:\\Program Files\\PowerShell\\7\\pwsh.exe'

local config = wezterm.config_builder()

-- Use powershell so we can use unix commands such as "ls" and "clear".
config.default_prog = { POWERSHELL }
config.font = wezterm.font 'JetBrains Mono'
config.font_size = 12
config.color_scheme = 'Catppuccin Macchiato'
config.enable_tab_bar = false
-- "RESIZE" so we can open the window as maximized without it overlapping the taskbar.
config.window_decorations = 'RESIZE'
config.window_padding = {
  top = 0,
  right = 0,
  bottom = 0,
  left = 16
  }
config.exit_behavior = 'Hold'
config.exit_behavior_messaging = 'None'

-- Define the function that will handle window creation.
wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
  local new_pane = pane:split({ direction = 'Right', size = 0.5, args = { POWERSHELL, '-Command', 'fastfetch' }})
  new_pane:split({ direction = 'Top', size = 0.03, args = { POWERSHELL, '-Command', 'fastfetch' }})
end)

return config