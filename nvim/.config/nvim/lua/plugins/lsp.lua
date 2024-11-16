return {
  {
    'williamboman/mason.nvim',
    lazy = false,
    opts = {
      ui = {
        border = 'rounded',
      },
    },
  },
  {
    'glepnir/lspsaga.nvim',
    opts = {
      ui = {
        border = 'rounded',
        code_action = ' ',
      },
      lightbulb = { enable = false },
      symbol_in_winbar = { enable = false },
    },
  },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    lazy = false,
    dependencies = {
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'L3MON4D3/LuaSnip' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'onsails/lspkind-nvim' },
      { 'rafamadriz/friendly-snippets' },
    },
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()

      local cmp = require 'cmp'
      cmp.setup {
        sources = {
          { name = 'path' },
          { name = 'nvim_lsp' },
          { name = 'luasnip', keyword_length = 2 },
          { name = 'buffer', keyword_length = 3 },
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<CR>'] = cmp.mapping.confirm { select = true },
        },
        preselect = 'item',
        completion = {
          completeopt = 'menu,menuone,noinsert',
        },
        formatting = {
          fields = { 'abbr', 'kind', 'menu' },
          format = require('lspkind').cmp_format {
            mode = 'symbol_text',
            maxwidth = 50,
            ellipsis_char = '...',
          },
        },
      }
    end,
  },
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
    },
    config = function()
      local lsp_defaults = require('lspconfig').util.default_config

      lsp_defaults.capabilities = vim.tbl_deep_extend('force', lsp_defaults.capabilities, require('cmp_nvim_lsp').default_capabilities())

      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
          local opts = { buffer = event.buf }

          vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc ++quiet<CR>', opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', 'gu', '<cmd>Lspsaga finder<CR>', opts)
          vim.keymap.set('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
          vim.keymap.set('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<CR>', opts)
          vim.keymap.set('n', 'gr', '<cmd>Lspsaga rename<CR>', opts)
          vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>', opts)
          vim.keymap.set('n', '<leader>so', '<cmd>Lspsaga outline<CR>', opts)
        end,
      })

      -- FIXME: Conform.nvim is overriding signs
      vim.diagnostic.config {
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '✘',
            [vim.diagnostic.severity.WARN] = '▲',
            [vim.diagnostic.severity.HINT] = '⚑',
            [vim.diagnostic.severity.INFO] = '»',
          },
        },
      }

      require('mason-lspconfig').setup {
        ensure_installed = {
          'lua_ls',
          'gopls',
          'ts_ls',
          'volar',
        },
        handlers = {
          function(server_name)
            require('lspconfig')[server_name].setup {}
          end,
          ts_ls = {
            init_options = {
              plugins = {
                {
                  name = '@vue/typescript-plugin',
                  location = require('mason-registry').get_package('vue-language-server'):get_install_path()
                    .. '/node_modules/@vue/language-server'
                    .. '/node_modules/@vue/typescript-plugin',
                  languages = { 'javascript', 'typescript', 'vue' },
                },
              },
              filetypes = {
                'javascript',
                'typescript',
                'vue',
              },
            },
          },
        },
      }
    end,
  },
}
