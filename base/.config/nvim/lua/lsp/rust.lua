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
