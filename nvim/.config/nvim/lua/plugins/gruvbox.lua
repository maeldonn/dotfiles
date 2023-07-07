return {
    "gruvbox-community/gruvbox",
    lazy = false,
    priority = 1000,
    config = function ()
        vim.g.gruvbox_invert_selection = '0'
        vim.cmd.colorscheme("gruvbox")

        vim.api.nvim_set_hl(0, "SignColumn", {bg = "none"})
        vim.api.nvim_set_hl(0, "CursorLineNR", {fg = "#fabd2f", bg = "none", bold = true})
    end,
}
