vim.g.mapleader = ","

vim.opt.rtp:prepend(vim.fn.stdpath("config") .. "/lazy.nvim")

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

----------------------------------------------------------------------------------------------------

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
    if client:supports_method('textDocument/completion') then
      -- Optional: trigger autocompletion on EVERY keypress. May be slow!
      -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
      -- client.server_capabilities.completionProvider.triggerCharacters = chars
      vim.lsp.completion.enable(true, client.id, args.buf, {autotrigger = false})
    end
    -- Auto-format ("lint") on save.
    -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
    if not client:supports_method('textDocument/willSaveWaitUntil')
        and client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('my.lsp', {clear=false}),
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
  end,
})

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
  },
})

vim.lsp.config("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
      diagnostics = {
        enable = true,
      },
      check = {
        -- Checking for the whole workspace can be really slow. Disabling just does it for the
        -- current crate.
        workspace = false,
      },
      cachePriming = {
        -- Does a bunch of work on first load to index everything.
        enable = false,
      },
    },
  },
})
vim.lsp.enable("rust_analyzer")

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
-- vim.keymap.set("i", "<C-space>", vim.lsp.completion.get)
