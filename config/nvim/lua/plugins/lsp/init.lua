return {
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    config = function()
      require("rust-tools").setup({
        tools = {
          executor = require("rust-tools.executors").toggleterm,
        },
        server = {
          on_attach = function(_, bufnr)
            -- Hover Actions
            vim.keymap.set(
              "n",
              "K",
              require("rust-tools").hover_actions.hover_actions,
              { buffer = bufnr, desc = "Hover" }
            )
          end,
        },
      })
    end,
  },

  {
    "nickeb96/fish.vim",
    ft = "fish",
  },

  {
    "saecki/crates.nvim",
    event = "BufRead Cargo.toml",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup({
        null_ls = {
          enabled = true,
          name = "Crates",
        },
      })
    end,
  },
}
