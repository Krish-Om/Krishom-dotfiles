return {
  "jiriks74/presence.nvim",
  event = "UIEnter",
  config = function()
    require("presence").setup({
      -- General options
      auto_update = true, -- Update activity based on autocmd events
      neovim_image_text = "The One True Text Editor", -- Text displayed when hovered over the Neovim image
      main_image = "neovim", -- Main image display
      log_level = nil, -- Log messages at or above this level
      debounce_timeout = 10, -- Number of seconds to debounce events
      enable_line_number = true, -- Displays the current line number instead of the current project
      blacklist = {}, -- A list of strings or Lua patterns that disable Rich Presence
      blacklist_repos = {}, -- A blacklist that applies to git remote repo URLs
      buttons = true, -- Configure Rich Presence button(s)
      file_assets = {}, -- Custom file asset definitions
      show_time = true, -- Show the timer

      -- Rich Presence text options
      editing_text = "Editing %s", -- Format string rendered when editing a file
      file_explorer_text = "Browsing %s", -- Format string rendered when browsing a file explorer
      git_commit_text = "Committing changes", -- Format string rendered when committing changes in git
      plugin_manager_text = "Managing plugins", -- Format string rendered when managing plugins
      reading_text = "Reading %s", -- Format string rendered when a read-only or unmodifiable file is loaded
      workspace_text = "Working on %s", -- Format string rendered when in a git repository
      line_number_text = "Line %s out of %s", -- Format string rendered when displaying line number
    })
  end,
}
