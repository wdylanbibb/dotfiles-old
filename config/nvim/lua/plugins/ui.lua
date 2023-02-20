return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.options.section_separators = {
        left = "",
        right = "",
      }
      opts.options.component_separators = {
        left = "",
        right = "",
      }
      opts.sections.lualine_y = {
        "filetype",
      }
      opts.sections.lualine_z = {
        { "progress", separator = " ", padding = { left = 1, right = 0 } },
        { "location", padding = { left = 0, right = 1 } },
      }
    end,
  },

  {
    "norcalli/nvim-colorizer.lua",
    event = "VeryLazy",
  },
}
