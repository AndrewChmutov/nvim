local lsp = require("lsp-zero")
local navic = require("nvim-navic")
local util = require("lspconfig.util")

require("fidget").setup({
    notification = {
        window = {
            winblend = 0,
        },
    },
})
require("mason").setup({
    PATH = "append",
})
require("mason-lspconfig").setup({
    ensure_installed = {
        "clangd",
        "lua_ls",
        "pyright",
        "ruff",
        "rust_analyzer@2024-10-14",
    },
})

local lspconfig_defaults = require("lspconfig").util.default_config
lspconfig_defaults.capabilities =
    vim.tbl_deep_extend("force", lspconfig_defaults.capabilities, require("blink.cmp").get_lsp_capabilities())

local function nodeSystemOrMason(name, node_module)
    local exepath = vim.fn.exepath(name)
    if string.find(exepath, "mason") then
        return vim.fn.expand("$MASON/packages/" .. name .. "/node_modules/" .. node_module)
    else
        return vim.fs.dirname(vim.fs.dirname(exepath)) .. "/lib/node_modules/" .. node_module
    end
end

lsp.configure("ts_ls", {
    init_options = {
        plugins = {
            {
                name = "@vue/typescript-plugin",
                location = nodeSystemOrMason("vue-language-server", "@vue/language-server"),
                languages = { "vue" },
            },
        },
    },
    filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
})

lsp.configure("gh_actions_ls", {
    filetypes = { "yaml.github" },
    root_dir = util.root_pattern(".github"),
    single_file_support = true,
    capabilities = {
        workspace = {
            didChangeWorkspaceFolders = {
                dynamicRegistration = true,
            },
        },
    },
})

lsp.configure("rust_analyzer", {
    settings = {
        ["rust-analyzer"] = {
            check = {
                command = "clippy",
            },
        },
    },
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function()
        vim.lsp.buf.definition()
    end, opts)
    vim.keymap.set("n", "K", function()
        vim.lsp.buf.hover()
    end, opts)
    vim.keymap.set("n", "<leader>vws", function()
        vim.lsp.buf.workspace_symbol()
    end, opts)
    vim.keymap.set("n", "<leader>vd", function()
        vim.diagnostic.open_float()
    end, opts)
    vim.keymap.set("n", "<leader>vca", function()
        vim.lsp.buf.code_action()
    end, opts)
    vim.keymap.set("n", "<leader>vrn", function()
        vim.lsp.buf.rename()
    end, opts)
    vim.keymap.set("i", "<C-k>", function()
        vim.lsp.buf.signature_help()
    end, opts)

    if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
    end
end)

lsp.setup()

vim.keymap.set("n", "<leader>lsp", ":LspR<CR>")
vim.keymap.set("n", "<leader>li", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end)

vim.diagnostic.config({
    virtual_text = true,
})
