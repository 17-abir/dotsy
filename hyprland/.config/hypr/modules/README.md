# Hyprland Modular Configuration

This directory contains the modularized Hyprland configuration. Each file handles a specific aspect of the WM configuration.

## Module Structure

- **monitors.lua** - Monitor/display configuration and layout
- **programs.lua** - Program definitions (terminal, file manager, menu) exported for use in other modules
- **autostart.lua** - Autostart processes and applications
- **env.lua** - Environment variables (XCURSOR_SIZE, etc.)
- **permissions.lua** - Permission settings for various applications
- **look_and_feel.lua** - Visual settings including:
  - General window appearance (gaps, borders, colors)
  - Decorations (rounding, shadows, blur)
  - Animations and curves
  - Layout configurations (dwindle, master, scrolling)
- **misc.lua** - Miscellaneous settings (wallpaper, splash screen)
- **input.lua** - Input device configuration (keyboard, mouse, touchpad, gestures)
- **keybindings.lua** - All keyboard and mouse bindings
- **window_rules.lua** - Window rules and layer rules

## Adding New Modules

1. Create a new `.lua` file in this directory
2. Add your configuration code
3. If needed, export values using `return { key = value }`
4. In the main `hyprland.lua`, add: `require("modules.yourmodule")`

## Cross-Module Dependencies

The **keybindings.lua** module imports from **programs.lua** to access program definitions:
```lua
local programs = require("modules.programs")
-- Then use: programs.terminal, programs.fileManager, programs.menu
```

You can extend this pattern for other shared configurations.
