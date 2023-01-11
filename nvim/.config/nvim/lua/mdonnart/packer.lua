-- Automatically install packer
local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
---@diagnostic disable-next-line: missing-parameter
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = vim.fn.system {
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
local packer = require("packer")

-- Have packer use a popup window
packer.init {
    snapshot_path = vim.fn.stdpath "config" .. "/snapshots",
    max_jobs = 50,
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
        prompt_border = "rounded", -- Border style of prompt popups.
    },
}

-- Install your plugins here
return packer.startup(function (use)
    use("wbthomason/packer.nvim")

    -- Code formatting
    use("sbdchd/neoformat")

    -- Telescope
    use("nvim-lua/plenary.nvim")
    use("nvim-lua/popup.nvim")
    use("nvim-telescope/telescope.nvim")

    -- Harpoon
    use("ThePrimeagen/harpoon")

    -- Git Integration
    use("TimUntersberger/neogit")
    use("lewis6991/gitsigns.nvim")

    -- Statusbar
    use({"nvim-lualine/lualine.nvim", requires = { 'kyazdani42/nvim-web-devicons', opt = true }})

    -- Code helpers
    use("windwp/nvim-autopairs")

    -- LSP & Completion
    use("neovim/nvim-lspconfig")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("onsails/lspkind-nvim")
    use("simrat39/symbols-outline.nvim")
    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")
    use("glepnir/lspsaga.nvim")

    -- Languages
    use("mfussenegger/nvim-jdtls")

    -- Treesitter
    use("nvim-treesitter/nvim-treesitter", {run = ":TSUpdate"})
    use("nvim-treesitter/playground")

    -- DAP
    use("mfussenegger/nvim-dap")
    use("rcarriga/nvim-dap-ui")
    use("theHamsta/nvim-dap-virtual-text")

    -- Colorscheme section 
    use("gruvbox-community/gruvbox")
    use("folke/tokyonight.nvim")
    use("catppuccin/nvim")

    -- Icons
    use("kyazdani42/nvim-web-devicons")
end)

