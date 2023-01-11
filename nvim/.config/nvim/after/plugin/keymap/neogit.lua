local neogit = require('neogit')

vim.keymap.set("n", "<leader>gs", function ()
    neogit.open({ })
end)

vim.keymap.set("n", "<leader>ga", "<cmd>!git fetch --all<CR>")

