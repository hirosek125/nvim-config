return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    keys = {
      { "<leader>sf", "<cmd>Telescope git_files<CR>", desc = "Find Files (root dir)" },
      { "<leader><space>", "<cmd>Telescope buffers<CR>", desc = "Find Buffers" },
      { "<leader>sg", "<cmd>Telescope live_grep<CR>", desc = "Search Project" },
      { "<leader>ss", "<cmd>Telescope lsp_document_symbols<CR>", desc = "Search Document Symbols" },
      { "<leader>sw", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", desc = "Search Workspace Symbols" },

      { "gd", "<cmd>Telescope lsp_definitions<CR>", desc = "Go to Definition" },
      { "gr", "<cmd>Telescope lsp_references<CR>", desc = "Go to References" },
      { "gi", "<cmd>Telescope lsp_implementations<CR>", desc = "Go to Implementations" },
      { "gt", "<cmd>Telescope lsp_type_definitions<CR>", desc = "Go to Type Definition" },
    },
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = {
          prompt_position = "top",
        },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      pcall(telescope.load_extension, "fzf")
    end,
  },
}
