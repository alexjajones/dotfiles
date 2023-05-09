local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
end)

lsp.setup()

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
    mapping = {
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<TAB>'] = cmp.mapping.select_next_item({ behavior = 'select' }),
        ['<S-TAB>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
    },
    sources = {
        { name = 'buffer' },
        { name = 'nvim_lsp' },
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
