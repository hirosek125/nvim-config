return {
  {
    "neovim/nvim-lspconfig",

    opts = {
      servers = {
        pyright = {},
        --gopls = {},
        lua_ls = {},
        jsonls = {},
        yamlls = {},
        rust_analyzer = {},
      },
    },
  },

  -- TypeScript の extras
  { import = "lazyvim.plugins.extras.lang.typescript" },

  -- LuaSnip の <Tab> 無効化
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },

  -- blink.cmp
  {
    "saghen/blink.cmp",
    opts = {
      cmdline = {
        keymap = {
          preset = "cmdline",
          ["<Up>"] = { "select_prev", "fallback" },
          ["<Down>"] = { "select_next", "fallback" },
        },
      },
    },
  },
}
