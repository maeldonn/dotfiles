vim.keymap.set("n", "<leader>f", "<cmd>Neoformat<CR>")

vim.keymap.set("v", "<leader>f", function()
    -- Récupérer la position de la sélection et executer la commande pour formater la sélection
    vim.cmd(":Neoformat")
end);

