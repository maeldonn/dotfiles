return {
  {
    'catppuccin/nvim',
    lazy = false,
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'catppuccin'
    end,
    config = function()
      require('catppuccin').setup { flavour = 'macchiato' }
    end,
  },
  { 'gruvbox-community/gruvbox' },
  { 'folke/tokyonight.nvim' },
  { 'rose-pine/neovim' },
}
