return {
    {
        "ray-x/go.nvim",
        config = function()
            require("go").setup()
        end,
        event = { "CmdlineEnter" },
        ft = { "go", "gomod" },
        build = function()
            require("go.install").update_all_sync()
        end
    },
    {
        "leoluz/nvim-dap-go",
        keys = {
            { "<leader>dt", function() require("dap-go").debug_test() end, desc = "Debug go test" }
        }
    }
}
