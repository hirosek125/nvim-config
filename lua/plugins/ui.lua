return {
  {
    "jacoborus/tender.vim",
    config = function()
      vim.cmd.colorscheme("tender")
    end,
  },

  {
    "petertriho/nvim-scrollbar",
    event = "VeryLazy",
    dependencies = {
      "kevinhwang91/nvim-hlslens",
    },
    opts = {
      show = true,
      handle = {
        color = "#888888",
      },
    },
    config = function(_, opts)
      require("scrollbar").setup(opts)
      require("scrollbar.handlers.search").setup()
      require("scrollbar.handlers.gitsigns").setup()
      require("scrollbar.handlers.diagnostic").setup()
    end,
  },

  {
    "kevinhwang91/nvim-hlslens",
    event = "VeryLazy",
    opts = {},
  },

  { "folke/trouble.nvim", enabled = false },
}
