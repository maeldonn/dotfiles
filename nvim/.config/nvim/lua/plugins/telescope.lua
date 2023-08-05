return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-lua/popup.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
    },
    keys = {
        { "<leader>ps", function() require("telescope.builtin").live_grep() end },
        { "<C-p>",      function() require("telescope.builtin").git_files({ previewer = false }) end },
        { "<leader>pf", function() require("telescope.builtin").find_files() end },
        { "<leader>pw", function() require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") }) end },
        { "<leader>pb", function() require("telescope.builtin").buffers() end },
        { "<leader>rv", function() require("telescope").extensions.file_browser.file_browser() end },
        { "<leader>pv", "<cmd>Telescope file_browser path=%:p:h<CR>" },
    },
    config = function()
        local telescope = require("telescope")
        telescope.setup({
            extensions = {
                file_browser = {
                    initial_mode = "normal",
                    hijack_netrw = true,
                },
            },
        })
        telescope.load_extension("file_browser")
    end,
}
