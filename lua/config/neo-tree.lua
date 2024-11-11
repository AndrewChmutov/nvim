vim.api.nvim_create_autocmd('BufEnter', {
    -- make a group to be able to delete it later
    group = vim.api.nvim_create_augroup('NeoTreeInit', {clear = true}),
    callback = function()
        local f = vim.fn.expand('%:p')
        if vim.fn.isdirectory(f) ~= 0 then
            vim.cmd('Neotree current dir=' .. f)
            -- neo-tree is loaded now, delete the init autocmd
            vim.api.nvim_clear_autocmds{group = 'NeoTreeInit'}
        end
    end
})

require("neo-tree").setup {
    filesystem = {
        hijack_netrw_behavior = "open_current"
    },
    window = {
        mappings = {
            ["o"] = "system_open",
        },
    },
    commands = {
        system_open = function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            -- Linux: open file in default application
            vim.fn.jobstart({ "xdg-open", path }, { detach = true })
        end
    },
}

vim.keymap.set("n", "<leader>pv", ":Neotree toggle<CR>")