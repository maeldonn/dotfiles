return {
    "nvim-treesitter/nvim-treesitter",
    build = function()
        local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
        ts_update()
    end,
    config = function()
        require("nvim-treesitter.configs").setup({
            enable = true,
            ensure_installed = "all",
            ignore_install = { "" },
            highlight = {
                enable = true,
                disable = { "" },
                additional_vim_regex_highlighting = false,
            },
            indent = { enable = true, disable = { "yaml" } },
            autotag = { enable = true },
        })
    end
}
