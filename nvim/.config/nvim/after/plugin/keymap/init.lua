local Remap = require("mdonnart.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap
local nmap = Remap.nmap

nnoremap("<leader>pv", ":Ex<CR>")

vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")

nnoremap("Y", "yg$")
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")
nnoremap("J", "mzJ`z")
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")

xnoremap("<leader>p", "\"_dP")

nnoremap("<leader>y", "\"+y")
vnoremap("<leader>y", "\"+y")
nmap("<leader>Y", "\"+Y")

nnoremap("<leader>d", "\"_d")
vnoremap("<leader>d", "\"_d")
vnoremap("<leader>d", "\"_d")

inoremap("<C-c>", "<Esc>")

nnoremap("Q", "<Nop>")

nnoremap("<Up>", "<Nop>")
nnoremap("<Down>", "<Nop>")
nnoremap("<Left>", "<Nop>")
nnoremap("<Right>", "<Nop>")
