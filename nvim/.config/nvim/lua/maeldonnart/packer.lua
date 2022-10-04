local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
---@diagnostic disable-next-line: missing-parameter
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    snapshot_path = fn.stdpath "config" .. "/snapshots",
    max_jobs = 50,
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
        prompt_border = "rounded", -- Border style of prompt popups.
    },
}

-- Install your plugins here
return packer.startup(function ()
    use("wbthomason/packer.nvim")

    -- Code formatting
    use("sbdchd/neoformat")

    -- Telescope
    use("nvim-lua/plenary.nvim")
    use("nvim-lua/popup.nvim")
    use("nvim-telescope/telescope.nvim")

    -- Harpoon
    use("ThePrimeagen/harpoon")

    -- Neovim
    use("TimUntersberger/neogit")

    -- Statusbar
    use("feline-nvim/feline.nvim")

    -- LSP Client
    use("neovim/nvim-lspconfig")
    use("mfussenegger/nvim-jdtls")

    -- Completion
    use("hrsh7th/nvim-cmp") 
    use("hrsh7th/cmp-nvim-lsp") 
    use("hrsh7th/cmp-buffer") 
    use("hrsh7th/cmp-path") 
    use("L3MON4D3/LuaSnip") 
    use("saadparwaiz1/cmp_luasnip") 

    -- Treesitter
    use("nvim-treesitter/nvim-treesitter", {run = ":TSUpdate"})
    use("nvim-treesitter/playground")

    -- DAP


    -- Colorscheme section  
    use("gruvbox-community/gruvbox")
    use("folke/tokyonight.nvim")
end)

