-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {},
        gopls = {},
        lua_ls = {},
        jsonls = {},
        yamlls = {},
        rust_analyzer = {},
      },
    },
  },

  { import = "lazyvim.plugins.extras.lang.typescript" },
}
