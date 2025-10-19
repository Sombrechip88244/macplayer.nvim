# ⏯ macplayer.nvim

### A simple, non-blocking Neovim plugin for macOS users to quickly toggle playback (Play/Pause) on multiple media applications without leaving the editor.

 # ✨ Features

Universal Toggle: Toggles playback for Spotify, Apple Music (Music), and Amazon Music.

Non-Blocking: Uses Neovim's vim.system() for asynchronous command execution.

macOS Exclusive: Leverages AppleScript for native control.

Noice Compatibility: Uses standard vim.notify(), which is automatically integrated with noice.nvim.

# 🚀 Installation

You can install this plugin using your favorite plugin manager.

lazy.nvim
```lua
return {
  'Sombrechip88244/macplayer.nvim',
  lazy = false, -- Load on startup
  -- Example configuration:
  config = function()
    require('macplayer').setup({
      -- Set to false if you use a statusline indicator or noice.nvim
      -- and prefer no floating message on successful toggles.
      show_notifications = true, 
    }),
  end,
}
```

### packer.nvim
```
use { 'Sombrechip88244/macplayer.nvim', config = 'require("macplayer").setup()' }
-- If using Packer with custom options:
-- use { 'YourGitHubUsername/macplayer.nvim', config = function() require("macplayer").setup({ show_notifications = false }) end }
```

# 🛠️ Usage

1. User Command

The plugin registers a global Neovim command:
```
:MacPlayerToggle
```

2. Key Mapping (Recommended)

Map the command to a convenient key combination:
```lua
-- Example mapping to <leader>m (e.g., Space + m) in Normal mode
vim.keymap.set('n', '<leader>m', '<cmd>MacPlayerToggle<CR>', { desc = 'Toggle Media Playback' })
```

3. Documentation

For full documentation and API details, run the help command inside Neovim:
```
:help macplayer.nvim
```

# ⚙️ Configuration (Defaults)

The plugin provides a simple setup function for configuration:
```lua
require('macplayer').setup({
  show_notifications = true, -- boolean (Default: true). Controls whether success/error messages appear.
})
```

⚠️ Notes

OS Compatibility: This plugin is strictly for macOS.

📄 License

Distributed under the MIT License. See LICENSE for more information.