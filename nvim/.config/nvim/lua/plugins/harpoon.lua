return {
    "ThePrimeagen/harpoon",
    keys = {
        { "<leader>a", function () require("harpoon.mark").add_file() end },
        { "<C-e>", function () require("harpoon.ui").toggle_quick_menu() end },
        { "<C-h>", function () require("harpoon.ui").nav_file(1) end },
        { "<C-j>", function () require("harpoon.ui").nav_file(2) end },
        { "<C-k>", function () require("harpoon.ui").nav_file(3) end },
        { "<C-l>", function () require("harpoon.ui").nav_file(4) end },
    }
}
