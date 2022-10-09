local Remap = require("mdonnart.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap

nnoremap("<leader>f", "<cmd>Neoformat<CR>")

vnoremap("<leader>f", function()
    -- Récupérer la position de la sélection et executer la commande pour formater la sélection
    vim.cmd(":Neoformat")
end);
