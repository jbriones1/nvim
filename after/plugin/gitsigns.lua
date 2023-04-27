local gitsigns = require('gitsigns')

---@diagnostic disable-next-line: unused-function
local function get_all_commits_of_buffer()
    local scripts = vim.api.nvim_exec('!git log --pretty=oneline --abbrev-commit --follow %', true)
    local res = vim.split(scripts, '\n')
    local output = {}
    for index = 3, #res - 1 do
        local item = res[index]
        local hash_id = string.sub(item, 1, 7)
        local message = string.sub(item, 8)
        output[index - 2] = { hash_id = hash_id, message = message }
    end
    return output
end

---@diagnostic disable-next-line: unused-function
local function isFugitiveFile()
    local filepath = vim.api.nvim_exec("echo expand('%:p')", true)
    return filepath:find("fugitive", 1, true) == 1
end

---@diagnostic disable-next-line: unused-function
local function diffWith()
    -- check if it is a fugitive file
    if isFugitiveFile() then
        vim.ui.input({ prompt = "Please input commit hash id to compare with current version: " }, function(input)
            vim.cmd("Gvdiffsplit! " .. input)
        end)
    else
        local commits = get_all_commits_of_buffer();

        vim.ui.select(commits, {
            prompt = "Select commit to compare with current file",
            format_item = function(item)
                return item.hash_id .. " > " .. item.message
            end,
        }, function(choice)
            gitsigns.diffthis(choice.hash_id)
            -- With vim-fugitive
            -- vim.cmd("Gvdiffsplit " .. choice.hash_id)
        end)
    end
end

gitsigns.setup {
    signs                        = {
        -- add          = { text = ' ' },
        -- change       = { text = ' ' },
        -- delete       = { text = ' ' },
        -- topdelete    = { text = '‾' },
        -- changedelete = { text = ' ' },
        -- untracked    = { text = ' ' },
        add          = { hl = 'GitSignsAdd', text = '┃', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
        change       = { hl = 'GitSignsChange', text = '┃', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
        delete       = { hl = 'GitSignsDelete', text = '▁', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
        topdelete    = { hl = 'GitSignsDelete', text = '▔', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
        changedelete = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
        untracked    = { hl = 'GitSignsAdd', text = '┆', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
    },
    signcolumn                   = true,  -- Toggle with `:Gitsigns toggle_signs`
    numhl                        = true,  -- Toggle with `:Gitsigns toggle_numhl`
    linehl                       = false,  -- Toggle with `:Gitsigns toggle_linehl`
    word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir                 = {
        interval = 1000,
        follow_files = true
    },
    attach_to_untracked          = true,
    current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts      = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 100,
        ignore_whitespace = false,
    },
    -- current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
    sign_priority                = 6,
    update_debounce              = 100,
    status_formatter             = nil,   -- Use default
    max_file_length              = 40000, -- Disable if file is longer than this (in lines)
    preview_config               = {
        -- Options passed to nvim_open_win
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
    },
    yadm                         = {
        enable = false
    },
    on_attach                    = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
        end, { expr = true })

        map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
        end, { expr = true })

        -- Actions
        map({ 'n', 'v' }, '<leader>ghs', ':Gitsigns stage_hunk<CR>', { desc = 'Stage hunk' })
        map({ 'n', 'v' }, '<leader>ghr', ':Gitsigns reset_hunk<CR>', { desc = 'Reset hunk' })
        map('n', '<leader>gS', gs.stage_buffer, { desc = 'Stage buffer' })
        map('n', '<leader>ghu', gs.undo_stage_hunk, { desc = 'Undo stage hunk' })
        map('n', '<leader>gR', gs.reset_buffer, { desc = 'Reset buffer' })
        map('n', '<leader>ghp', gs.preview_hunk, { desc = 'Preview hunk' })
        map('n', '<leader>gB', function() gs.blame_line { full = true } end, { desc = ' Show blame info' })
        map('n', '<leader>gb', gs.toggle_current_line_blame, { desc = 'Toggle blame line' })
        map('n', '<leader>gd', diffWith, { desc = 'Diff with' })
    end }
