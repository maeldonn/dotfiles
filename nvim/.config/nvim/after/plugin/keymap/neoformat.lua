local Remap = require("maeldonnart.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap

nnoremap("==", "<cmd>Neoformat<CR>")

vnoremap("==", function()
    -- Récupérer la position de la sélection et executer la commande pour formater la sélection
    vim.cmd(":Neoformat")
end);
