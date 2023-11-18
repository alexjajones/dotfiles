local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        -- null_ls.builtins.completion.spell,
        null_ls.builtins.formatting.black.with({
            args = { "--stdin-filename", "$FILENAME", "--line-length=100", "--quiet", "-" }
        })
    },
})
