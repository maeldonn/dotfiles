local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Code formatting
    "sbdchd/neoformat",

    -- Telescope
    "nvim-lua/plenary.nvim",
    "nvim-lua/popup.nvim",
    "nvim-telescope/telescope.nvim",

    -- Harpoon
    "ThePrimeagen/harpoon",

    -- Git Integration
    "kdheepak/lazygit.nvim",
    "lewis6991/gitsigns.nvim",

    -- Statusbar
    {"nvim-lualine/lualine.nvim", dependencies = {'kyazdani42/nvim-web-devicons', opt = true}},

    -- Code helpers
    "windwp/nvim-autopairs",

    -- LSP & Completion
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "onsails/lspkind-nvim",
    "simrat39/symbols-outline.nvim",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "glepnir/lspsaga.nvim",

    -- Languages
    "mfussenegger/nvim-jdtls",

    -- Treesitter
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    "nvim-treesitter/playground",

    -- DAP
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",

    -- Colorscheme section 
    "gruvbox-community/gruvbox",
    "folke/tokyonight.nvim",
    "catppuccin/nvim",

    -- Icons
    "kyazdani42/nvim-web-devicons",
})

