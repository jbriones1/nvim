local null_ls = require('null-ls')
local mason_null_ls = require('mason-null-ls')

-- local group = vim.api.nvim_create_augroup('lsp_format_on_save', { clear = false })
local event = 'BufWritePre' -- or 'BufWritePost'
-- local async = event == 'BufWritePost'

mason_null_ls.setup({
    automatic_setup = true
})

local function no_auto_save(filetype)
    return filetype ~= 'html' and filetype ~= 'javascript' and filetype ~= 'json'
end

null_ls.setup({
    debug = true,
    sources = {
        null_ls.builtins.formatting.prettierd.with({
            env = {
                PRETTIERD_DEFAULT_CONFIG = vim.fn.expand('$HOME/.config/nvim/.prettierrc')
            },
            filetypes = {
                'css',
                'html',
                'json',
                'less',
                'markdown',
                'scss',
                'typescript',
                'typescriptreact',
                'javascript',
                'yaml'
            }
        }),
        null_ls.builtins.diagnostics.eslint_d
    },
    on_attach = function(client, bufnr)
        if client.supports_method('textDocument/formatting') then
            vim.keymap.set('n', '<leader>f', function()
                vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf(), timeout_ms = 3000 })
            end, { buffer = bufnr, desc = 'LSP format' })

            -- format on save, except for html and javascript
        --     if vim.bo.filetype ~= 'html' and vim.bo.filetype ~= 'javascript' then
        --         vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
        --         vim.api.nvim_create_autocmd(event, {
        --             buffer = bufnr,
        --             group = group,
        --             callback = function()
        --                 vim.lsp.buf.format({ bufnr = bufnr, async = async })
        --             end,
        --             desc = '[lsp] format on save',
        --         })
        --     end
        end

        if client.supports_method('textDocument/rangeFormatting') then
            vim.keymap.set('x', '<Leader>f', function()
                vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
            end, { buffer = bufnr, desc = 'LSP format' })
        end
    end
})
