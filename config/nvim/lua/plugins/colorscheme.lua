return {
  {
    "navarasu/onedark.nvim",
    opts = {
      transparent = true,
      code_style = {
        strings = "italic",
      },
      lualine = {
        transparent = true,
      },
      colors = {
        cyan = "#70BAC4",
      },
    },
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      transparent_background = true,
      styles = {
        strings = { "italic" },
      },
      integrations = {
        notify = true,
        which_key = true,
        gitsigns = true,
        lsp_trouble = true,
        noice = true,
        navic = true,
      },
    },
  },
}
