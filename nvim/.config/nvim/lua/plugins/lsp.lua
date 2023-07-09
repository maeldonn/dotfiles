return {
    "neovim/nvim-lspconfig",

    dependencies = {
        -- LSP support
        { "glepnir/lspsaga.nvim" },
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },

        -- Autocompletion
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/nvim-cmp" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "saadparwaiz1/cmp_luasnip" },
        { "onsails/lspkind-nvim" },

        -- Snippets
        {
            "L3MON4D3/LuaSnip",
            dependencies = {
                "rafamadriz/friendly-snippets"
            }
        },
    },

    config = function ()
        local cmp = require("cmp")
        local source_mapping = {
	        buffer = "[Buffer]",
	        nvim_lsp = "[LSP]",
	        nvim_lua = "[Lua]",
	        path = "[Path]",
	        luasnip = "[Snippet]",
        }

        vim.diagnostic.config({
            virtual_text = true,
            signs = true,
            update_in_insert = false,
            underline = true,
            severity_sort = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })

        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
            border = "rounded",
        })

        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
            border = "rounded",
        })

        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "gopls",
                "tsserver",
                "rust_analyzer",
            }
        })

        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                ['<C-d>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
            }),
            formatting = {
                format = function(entry, vim_item)
                    vim_item.kind = require("lspkind").presets.default[vim_item.kind]
                    vim_item.menu = source_mapping[entry.source.name]
                    return vim_item
                end,
            },
            sources = {
                  { name = "nvim_lsp" },
                  { name = "luasnip" },
                  { name = "buffer" },
                  { name = "path" },
            },
        })

        require("lspsaga").setup({
            ui = {
                border = "rounded",
                code_action = " ",
                colors = {
                    normal_bg = "#282828",
                    title_bg = '#282828',
                    black =  '#282828',
                    red = '#cc241d',
                    green = '#98971a',
                    yellow = '#d79921',
                    blue = '#458588',
                    magenta = '#b16286',
                    cyan = '#689d6a',
                    white = '#a89984',
                },
            },
            lightbulb = {
                enable = false,
            },
            symbol_in_winbar = {
                enable = false,
            },
        })

        local function config(_config)
            return vim.tbl_deep_extend("force", {
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
                on_attach = function()
        			vim.keymap.set("n" ,"K", "<cmd>Lspsaga hover_doc ++quiet<CR>")
                    vim.keymap.set("n" ,"gd", function() vim.lsp.buf.definition() end)
        			vim.keymap.set("n" ,"gt", function() vim.lsp.buf.type_definition() end)
        			vim.keymap.set("n" ,"gi", function() vim.lsp.buf.implementation() end)
                    vim.keymap.set("n" ,"gu", "<cmd>Lspsaga finder<CR>")
                    vim.keymap.set("n" ,"[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
                    vim.keymap.set("n" ,"]d", "<cmd>Lspsaga diagnostic_jump_next<CR>")
                    vim.keymap.set("n" ,"gr", "<cmd>Lspsaga rename<CR>")
        			vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end)
        			vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>")
        			vim.keymap.set("n", "<leader>so", "<cmd>Lspsaga outline<CR>")
                end,
            }, _config or {})
        end

        require("lspconfig").gopls.setup(config())

        require("lspconfig").tsserver.setup(config())

        require("lspconfig").rust_analyzer.setup(config({
            cmd = { "rustup", "run", "stable", "rust-analyzer" },
        }))

        require("lspconfig").lua_ls.setup(config({
            settings = {
                Lua = {
        			runtime = {
        				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        				version = "LuaJIT",
        				-- Setup your lua path
        				path = vim.split(package.path, ";"),
        			},
        			diagnostics = {
        				-- Get the language server to recognize the `vim` global
        				globals = { "vim" },
        			},
        			workspace = {
        				-- Make the server aware of Neovim runtime files
        				library = {
        					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
        					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
        				},
        			},
                },
            },
        }))

        -- Snippets
        require("luasnip.loaders.from_vscode").lazy_load()
    end
}
