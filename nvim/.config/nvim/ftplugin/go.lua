local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimport()
  end,
  group = format_sync_grp,
})

require('go').setup()
require('dap-go').setup()

vim.keymap.set("n", "<leader>dt", function ()
    require("dap-go").debug_test()
end)

