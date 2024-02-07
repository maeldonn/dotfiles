return {
    {
        "ray-x/go.nvim",
        keys = {
            { "<leader>ee", "<cmd>GoIfErr<CR>" },
        },
        config = function()
            require("go").setup()
        end,
        event = { "CmdlineEnter" },
        ft = { "go", "gomod" },
        build = function()
            require("go.install").update_all_sync()
        end
    }
}
