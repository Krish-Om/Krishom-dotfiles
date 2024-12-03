return {
	{
		"sainnhe/sonokai",
		priority = 1,
		config = function()
			vim.g.sonokai_transparent_background = "1"
			vim.g.sonokai_enable_italic = "1"
			vim.g.sonokai_style = "andromeda"
			vim.cmd.colorscheme("sonokai")
		end,
	},
	{
	  "catppuccin/nvim",
	  lazy = false,
	  name = "catppuccin",
	  priority = 1000,
  
	  config = function()
		require("catppuccin").setup({
		  transparent_background = true,
		})
		vim.cmd.colorscheme("catppuccin-mocha")
	  end,
	},
  }