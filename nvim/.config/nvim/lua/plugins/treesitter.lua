return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs',
  opts = {
    auto_install = true,
    ensure_installed = {
      'vim',
      'lua',
      'bash',
      'go',
      'gomod',
      'gosum',
      'sql',
      'dockerfile',
      'yaml',
      'json',
      'markdown',
      'javascript',
      'typescript',
      'css',
      'vue',
    },
    highlight = {
      enable = true,
      disable = { '' },
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true, disable = { 'yaml' } },
    autotag = { enable = true },
  },
}
