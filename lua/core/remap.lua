vim.g.mapleader = " "

-- move lines with vscode-ish style
vim.keymap.set("v", "K", ":m '<-2<CR>gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv")

vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true })

vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set("n", "<leader>te", ":!")

vim.keymap.set("n", "<leader>sc", function()
    if vim.o.scrolloff == 99999 then
        vim.opt.scrolloff = 8
    else
        vim.opt.scrolloff = 99999
    end
end, { noremap = true })


vim.keymap.set("n", "<leader>xx", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>d", ":!cd %:p:h<CR>:cd %:p:h<CR>")

-- tabs
-- vim.api.nvim_set_keymap('n', '<leader>tn', ':tabnew<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>t<leader>', ':tabnext<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>tm', ':tabmove<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>tc', ':tabclose<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>to', ':tabonly<CR>', { noremap = true, silent = true })
