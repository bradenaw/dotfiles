return {
    -- 'airblade/vim-gitgutter',
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
    'simrat39/rust-tools.nvim',
}
