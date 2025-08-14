local neogit = require("neogit")
neogit.setup({
    disable_context_highlighting = true,
    graph_style = "unicode",
    highlight = {
        bg1 = "",
    }
})

vim.keymap.set("n", "<leader>gs", function()
    neogit.open({ kind = "replace" })
end)
