vim.keymap.set("n", "K", function()
  vim.lsp.buf.hover({
    border = "rounded",
    wrap = false,
  })
end, { silent = true })

vim.keymap.set("n", "<leader>d", function()
  vim.diagnostic.open_float({ border = "rounded" })
end, { silent = true })

vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format)
