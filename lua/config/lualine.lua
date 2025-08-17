require('lualine').setup({
    options = {
        theme = "gruvbox_light",
    },
    sections = {
        lualine_c = { { "filename", path = 1 } },
    }
})
