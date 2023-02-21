return {
  {
    "akinsho/toggleterm.nvim",
    opts = {
      open_mapping = [[<c-\>]],
      direction = "float",
      float_opts = {
        border = "curved",
      },
    },
    cmd = { "ToggleTerm" },
    keys = { [[<c-\>]] },
  },

  {
    "sindrets/diffview.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = { "DiffviewOpen" },
  },

  {
    "max397574/better-escape.nvim",
    event = "VeryLazy",
    config = true,
  },

  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    config = true,
  },
}
