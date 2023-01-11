function ColorMyPencils(color)
    vim.g.gruvbox_invert_selection = '0'

    color = color or "gruvbox"
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "SignColumn", {bg = "none"})
    vim.api.nvim_set_hl(0, "CursorLineNR", {fg = "#fabd2f", bg = "none", bold = true})
end

ColorMyPencils()

