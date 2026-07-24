return {
  -- LuaSnip
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
