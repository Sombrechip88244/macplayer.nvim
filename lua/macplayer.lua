-- lua/macplayer.lua
-- Core module for the macplayer.nvim plugin.

local M = {}
local opts = {} -- Store configuration options

-- The AppleScript code to toggle playback across supported applications:
-- Spotify, Music (Apple Music), and Amazon Music.
local ASCRIPT_CODE = [[
  set app_names to {"Spotify", "Music", "Amazon Music"}
  repeat with app_name in app_names
    try
      -- Check if the application is running
      if application app_name is running then
        -- Tell the app to toggle its playback state (playpause)
        tell application app_name to playpause
      end if
    on error
      -- Silently ignore errors, allowing the loop to continue
    end try
  end repeat
]]

-- Prepare the shell command by escaping quotes for osascript
local ASCRIPT_SHELL_COMMAND = "osascript -e '" .. ASCRIPT_CODE:gsub("\n", "\\\n"):gsub("'", "'\"'\"'") .. "'"

-- Helper function to conditionally notify the user
local function notify(msg, level)
    if opts.show_notifications then
        -- This is the function that noice.nvim automatically hijacks
        vim.notify(msg, level, { title = "MacPlayer", timeout = 1000 })
    end
end

--- Toggles the media playback state (Play/Pause) for multiple media players.
function M.toggle_playback()
    if vim.fn.has('mac') == 0 then
        notify("macplayer.nvim: This plugin only works on macOS.", vim.log.levels.WARN)
        return
    end

    -- Run the shell command asynchronously to prevent Neovim from freezing
    vim.system({ "bash", "-c", ASCRIPT_SHELL_COMMAND }, { text = true }, function(result)
        if result.code ~= 0 then
            -- Handle shell execution errors
            local error_msg = string.format("Media Toggle Error (%d): %s", result.code, result.stderr)
            notify(error_msg, vim.log.levels.ERROR)
        else
            -- Success notification
            notify("Media playback toggled.", vim.log.levels.INFO)
        end
    end)
end

--- The main setup function. Allows configuration, including notification visibility.
--- @param user_opts table|nil Configuration table
function M.setup(user_opts)
    -- Merge default options with user provided options
    opts = vim.tbl_deep_extend("force", {
        show_notifications = true, -- Default: show notifications via vim.notify
    }, user_opts or {})

    -- Create the user command available within Neovim
    vim.api.nvim_create_user_command(
        'MacPlayerToggle',
        M.toggle_playback,
        { desc = 'Toggle Play/Pause for supported macOS media players' }
    )
end

return M
