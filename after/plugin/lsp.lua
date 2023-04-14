-- local lsp = require('lsp-zero')
--
-- lsp.preset('recommended')
--
-- require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
--
-- local cmp = require('cmp')
-- -- local cmp_select = { behavior = cmp.SelectBehavior.Select }
-- local cmp_mappings = lsp.defaults.cmp_mappings({
--     ['<CR>'] = cmp.mapping.confirm({ select = false }),
--     ['<C-Space>'] = cmp.mapping.complete()
-- })
--
-- lsp.setup_nvim_cmp({
--     mapping = cmp_mappings
-- })
--
-- lsp.on_attach(function(client, bufnr)
--   lsp.default_keymaps({buffer = bufnr})
-- end)
--
-- lsp.setup()
-- map('n', 'ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
-- map('n', '<leader>e', ':lua vim.diagnostic.open_float(0, {scope='line'})<CR>')
local lsp = require('lsp-zero').preset({})
local lspconfig = require('lspconfig')

lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set('n', '<leader>vw', function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set('n', '[d', function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set('n', ']d', function() vim.diagnostic.goto_prev() end, opts)
    -- vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end, opts)
    -- vim.keymap.set('n', '<leader>vrr', function() vim.lsp.buf.references() end, opts)
    -- vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'buffer',  keyword_length = 3 },
        { name = 'luasnip', keyword_length = 2 }
    },
    mapping = {
        -- `Enter` key to confirm completion
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        -- Ctrl+Space to trigger completion menu
        ['<C-Space>'] = cmp.mapping.complete(),
        -- Navigate between snippet placeholder
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),
    }
})

map('n', '<leader>e', ':lua vim.diagnostic.open_float(0, {scope="line"})<CR>')
