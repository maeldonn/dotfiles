return {
    "glepnir/lspsaga.nvim",
    keys = {
        { "K", "<cmd>Lspsaga hover_doc ++quiet<CR>" },
        { "gu", "<cmd>Lspsaga lsp_finder<CR>" },
        { "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>" },
        { "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>" },
        { "gr", "<cmd>Lspsaga rename<CR>" },
        { "<leader>ca", "<cmd>Lspsaga code_action<CR>" },
        { "<leader>so", "<cmd>Lspsaga outline<CR>" },
    },
    opts = {
        ui = {
            border = "rounded",
            code_action = " ",
            colors = {
                normal_bg = "#282828",
                title_bg = '#282828',
                black =  '#282828',
                red = '#cc241d',
                green = '#98971a',
                yellow = '#d79921',
                blue = '#458588',
                magenta = '#b16286',
                cyan = '#689d6a',
                white = '#a89984',
            },
        },
        lightbulb = {
            enable = false,
        },
        symbol_in_winbar = {
            enable = false,
        },
    }
}
