return {
    'neovim/nvim-lspconfig',
    {
        'saghen/blink.cmp',
        -- optional: provides snippets for the snippet source
        dependencies = { 'rafamadriz/friendly-snippets' },
        version = '1.*',
        opts = {
            keymap = { preset = 'super-tab' },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
        },
        opts_extend = { "sources.default" }
    },
    'lewis6991/gitsigns.nvim',
    {
        'luukvbaal/statuscol.nvim',
        config = function()
            local builtin = require("statuscol.builtin")
            require("statuscol").setup({
                setopt = true,
                segments = {
                    { sign = { namespace = { "gitsigns" }, maxwidth = 1, colwidth = 1, auto = true }, },
                    { sign = { namespace = { "diagnostic" }, maxwidth = 1, colwidth = 1, auto = true }, },
                    { text = { builtin.lnumfunc } },
                    { text = { " " } },
                },
            })
        end,
    },
    {
        'google/vim-jsonnet',
        ft = 'jsonnet',
    },
    {
        'linrongbin16/lsp-progress.nvim',
        config = function()
            require('lsp-progress').setup()
        end,
    },
    {
        "scalameta/nvim-metals",
        ft = { "scala", "sbt", "java" },
        opts = function()
            local metals_config = require("metals").bare_config()
            metals_config.on_attach = function(client, bufnr)
                -- your on_attach function
            end

            metals_config.settings.metalsBinaryPath = vim.fn.expand('~/bin/metals')

            return metals_config
        end,
        config = function(self, metals_config)
            local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
            vim.api.nvim_create_autocmd("FileType", {
                pattern = self.ft,
                callback = function()
                    require("metals").initialize_or_attach(metals_config)
                end,
                group = nvim_metals_group,
            })
        end
    }
}
