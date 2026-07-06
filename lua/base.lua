--vim.cmd("autocmd!")

vim.scriptencoding = "utf-8"

vim.wo.number = true

-- Open hoge file
vim.api.nvim_create_user_command("Hoge", function(opts)
  vim.cmd("e " .. "~/_/hoge/hoge.markdown")
end, {})

vim.o.updatetime = 300 -- カーソルを止めてからポップアップが出るまでの時間(ms)。デフォルトは4000msと長いので短縮推奨

vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, {
      focusable = true,
      scope = "cursor", -- カーソル位置の診断のみ表示
    })
  end,
})
