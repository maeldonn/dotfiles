vim.g.mdonnart_colorscheme = "gruvbox"

function ColorMyPencils()
    vim.g.tokyonight_transparent_sidebar = true
    vim.g.tokyonight_transparent = true
    vim.g.gruvbox_invert_selection = '0'
    vim.opt.background = "dark"

    vim.cmd("colorscheme " .. vim.g.mdonnart_colorscheme)

    vim.api.nvim_set_hl(0, "SignColumn", {bg = "none"})
    vim.api.nvim_set_hl(0, "CursorLineNR", {fg = "#fabd2f", bg = "none", bold = true})
end

ColorMyPencils()
