function ColorMyPencils(color)
	color = color or "nordic"
	vim.cmd.colorscheme(color)

	-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    -- vim.cmd [[
    --     highlight SignColumn guibg=NONE
    -- ]]
	
end

ColorMyPencils()
