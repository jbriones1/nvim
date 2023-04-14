-- {{ Vim code dark }}
vim.cmd([[ colorscheme codedark ]])
-- {{ Dark plus }}
-- vim.cmd('colorscheme darkplus')

-- {{ Onedark }}
-- require('onedark').setup {
-- 	style = 'darker'
--}
--require('onedark').load()

-- {{ VSCode }}
-- local c = require('vscode.colors').get_colors()
-- require('vscode').setup({
--     -- Alternatively set style in setup
--     -- style = 'light'
--
--     -- Disable nvim-tree background color
--     disable_nvimtree_bg = true,
--
--     -- Override highlight groups (see ./lua/vscode/theme.lua)
--     group_overrides = {
--         -- this supports the same val table as vim.api.nvim_set_hl
--         -- use colors from this colorscheme by requiring vscode.colors!
--         Cursor = { fg=c.vscDarkBlue, bg=c.vscLightGreen, bold=true },
--     }
-- })
-- require('vscode').load()
