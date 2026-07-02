return {
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      local lint = require("lint")

      lint.linters_by_ft = lint.linters_by_ft or {}
      lint.linters_by_ft.markdown = { "vale" }
    end,
  },
}
