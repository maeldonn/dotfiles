return {
    "ray-x/go.nvim",
    build = function ()
        require("go.install").update_all_sync()
    end
}
