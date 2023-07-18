return {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    dependencies = {
        { "neovim/nvim-lspconfig" },
        {
            "williamboman/mason.nvim",
            opts = { ui = { border = "rounded" } },
            build = function()
                pcall(vim.cmd, "MasonUpdate")
            end,
        },
        { "williamboman/mason-lspconfig.nvim" },
        { "hrsh7th/nvim-cmp" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "saadparwaiz1/cmp_luasnip" },
        { "onsails/lspkind-nvim" },
        {
            "glepnir/lspsaga.nvim",
            opts = {
                ui = {
                    border = "rounded",
                    code_action = " ",
                    colors = {
                        normal_bg = "#282828",
                        title_bg = "#282828",
                        black = "#282828",
                        red = "#cc241d",
                        green = "#98971a",
                        yellow = "#d79921",
                        blue = "#458588",
                        magenta = "#b16286",
                        cyan = "#689d6a",
                        white = "#a89984",
                    },
                },
                lightbulb = {
                    enable = false,
                },
                symbol_in_winbar = {
                    enable = false,
                },
            }
        },
        {
            "L3MON4D3/LuaSnip",
            dependencies = {
                "rafamadriz/friendly-snippets"
            }
        },
    },
    config = function()
        local lsp = require("lsp-zero")

        lsp.preset("recommended")

        lsp.ensure_installed({
            "lua_ls",
            "gopls",
            "tsserver",
        })

        -- Fix undefined globale 'vim'
        require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

        require("luasnip.loaders.from_vscode").lazy_load()

        local cmp = require("cmp")
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        local cmp_mappings = lsp.defaults.cmp_mappings({
            ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
            ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
            ["<C-Space>"] = cmp.mapping.complete(),
        })

        cmp_mappings["<Tab>"] = nil
        cmp_mappings["<S-Tab>"] = nil

        lsp.setup_nvim_cmp({
            mapping = cmp_mappings
        })

        lsp.format_on_save({
            format_opts = {
                async = false,
                timeout_ms = 10000,
            },
            servers = {
                ["lua_ls"] = { "lua" },
                ["gopls"] = { "go" },
            }
        })

        lsp.set_sign_icons({
            error = "✘",
            warn = "▲",
            hint = "⚑",
            info = "»"
        })

        lsp.on_attach(function(client, bufnr)
            local opts = { buffer = bufnr, remap = false }

            vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc ++quiet<CR>", opts)
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
            vim.keymap.set("n", "gu", "<cmd>Lspsaga finder<CR>", opts)
            vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
            vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
            vim.keymap.set("n", "gr", "<cmd>Lspsaga rename<CR>", opts)
            vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
            vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
            vim.keymap.set("n", "<leader>so", "<cmd>Lspsaga outline<CR>", opts)
        end)

        lsp.setup()

        cmp.setup({
            preselect = "item",
            completion = {
                completeopt = "menu,menuone,noinsert"
            },
            formatting = {
                fields = { "abbr", "kind", "menu" },
                format = require("lspkind").cmp_format({
                    mode = "symbol_text",
                    maxwidth = 50,
                    ellipsis_char = "...",
                })
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
        })
    end
}
