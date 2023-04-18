local lsp = require('lsp-zero').preset({})
local lspconfig = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local lsp_highlighting = vim.api.nvim_create_augroup("lsp_document_highlight", {})

lspconfig.emmet_ls.setup({
    capabilities = capabilities,
    filetypes = { 'html' },
    init_options = {}
})

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
    vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)

    -- Autohighlighting
    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            callback = vim.lsp.buf.document_highlight,
            buffer = bufnr,
            group = lsp_highlighting,
            desc = "Document Highlight",
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
            callback = vim.lsp.buf.clear_references,
            buffer = bufnr,
            group = lsp_highlighting,
            desc = "Clear All the References",
        })
    end

    -- Semantic highlighting for C
    if capabilities.semanticTokensProvider and capabilities.semanticTokensProvider.full then
        local group = vim.api.nvim_create_augroup('SemanticTokens', {})
        vim.api.nvim_create_autocmd('TextChanged', {
            group = group,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.semantic_tokens_full()
            end
        })
        vim.lsp.buf.semantic_tokens_full()
    end
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

Map('n', 'vca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
Map('n', '<leader>e', ':lua vim.diagnostic.open_float(0, {scope="line"})<CR>')
