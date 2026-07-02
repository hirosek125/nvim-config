-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- add tender.vim
  {
    "jacoborus/tender.vim", -- tender.vimプラグインの追加
    config = function()
      vim.cmd([[colorscheme tender]]) -- カラースキームの設定
    end,
  },

  -- change trouble config
  {
    "folke/trouble.nvim",
    -- opts will be merged with the parent spec
    opts = { use_diagnostic_signs = true },
  },

  -- disable trouble
  { "folke/trouble.nvim", enabled = false },

  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = false,
          git_ignored = false,
        },
      })
      -- キーマッピング
      vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file tree" })
    end,
  },
  -- add symbols-outline
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    config = true,
  },

  -- change some telescope options and a keymap to browse plugin files
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    keys = {
      -- add a keymap to browse plugin files
      { "<leader>sf", "<cmd>Telescope git_files<cr>", desc = "Find Files (root dir)" },
      { "<leader><space>", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
      { "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Search Project" },
      { "<leader>ss", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Search Document Symbols" },
      { "<leader>sw", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Search Workspace Symbols" },

      -- go to
      { "gd", "<cmd>Telescope lsp_definitions<cr>", desc = "Go to Definition" },
      { "gr", "<cmd>Telescope lsp_references<cr>", desc = "Go to References" },
      { "gi", "<cmd>Telescope lsp_implementations<cr>", desc = "Go to Implementations" },
      { "gt", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Go to Type Definition" },
    },
    -- change some options
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("fzf")
    end,
  },

  -- add tsserver and setup with typescript.nvim instead of lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
    },
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      pcall(function()
        capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
      end)

      require("mason").setup()
      local mason_lspconfig = require("mason-lspconfig")

      mason_lspconfig.setup({
        ensure_installed = {
          "pyright",
          "ts_ls",
          "lua_ls",
          "jsonls",
          "vtsls",
          "gopls",
        },
      })

      -- python
      require("lspconfig").pyright.setup({
        capabilities = capabilities,
      })

      -- typescript
      require("typescript").setup({
        capabilities = capabilities,
      })

      -- go
      require("lspconfig").gopls.setup({
        capabilities = capabilities,
      })
    end,

    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- tsserver will be automatically installed with mason and loaded with lspconfig
        tsserver = {},
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        tsserver = function(_, opts)
          require("typescript").setup({ server = opts })
          return true
        end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
  },

  -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
  -- treesitter, mason and typescript.nvim. So instead of the above, you can use:
  { import = "lazyvim.plugins.extras.lang.typescript" },

  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },

      auto_install = false,
      highlight = { enable = true, additional_vim_regex_highlighting = false },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-n>",
          node_incremental = "<C-n>",
          scope_incremental = "<C-s>",
          node_decremental = "<C-m>",
        },
      },
    },
  },

  -- add any tools you want to have installed below
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "black" },
        lua = { "stylua" },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        python = { "ruff" },
      },
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function(_, opts)
      local lint = require("lint")
      lint.linters_by_ft = opts.linters_by_ft

      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  }, -- Use <tab> for completion and snippets (supertab)
  -- first: disable default <tab> and <s-tab> behavior in LuaSnip
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
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
