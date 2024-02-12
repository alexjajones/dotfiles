local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
end)

lsp.setup()

local cmp = require('cmp')

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = {
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<TAB>'] = cmp.mapping.select_next_item({ behavior = 'select' }),
        ['<S-TAB>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
    }
})

cmp.setup.filetype('markdown', {
    sources = {
        { name = 'buffer' },
    }
})

vim.diagnostic.config({
    virtual_text = false
})
