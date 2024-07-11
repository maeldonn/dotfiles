return {
    {
        "catppuccin/nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "macchiato",
                transparent_background = true,
            })
            vim.cmd.colorscheme("catppuccin")
        end,
    },
    { "gruvbox-community/gruvbox" },
    { "folke/tokyonight.nvim" },
    { "rose-pine/neovim" },
}
