require('lualine').setup({
    options = {
        theme = 'tokyonight'
    },
    sections = {
        lualine_c = {
            {
                'filename',
                path = 3,
                symbols = {
                    modified = '[Modified]',
                    readonly = '[Read only]'
                }
            }
        }
    }
})
