local Remap = require("mdonnart.keymap")
local inoremap = Remap.inoremap
local nnoremap = Remap.nnoremap

local cmp = require("cmp")
local lspkind = require("lspkind")
local source_mapping = {
	buffer = "[Buffer]",
	nvim_lsp = "[LSP]",
	nvim_lua = "[Lua]",
	path = "[Path]",
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
            vim_item.kind = lspkind.presets.default[vim_item.kind]
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

local function config(_config)
    return vim.tbl_deep_extend("force", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        on_attach = function()
			nnoremap("K", "<cmd>Lspsaga hover_doc<CR>")
            nnoremap("gd", function() vim.lsp.buf.definition() end)
			nnoremap("gt", function() vim.lsp.buf.type_definition() end)
			nnoremap("gi", function() vim.lsp.buf.implementation() end)
            nnoremap("gu", "<cmd>Lspsaga lsp_finder<CR>")
            nnoremap("[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
            nnoremap("]d", "<cmd>Lspsaga diagnostic_jump_next<CR>")
            nnoremap("gr", "<cmd>Lspsaga rename<CR>")
			inoremap("<C-h>", function() vim.lsp.buf.signature_help() end)
			nnoremap("<leader>ca", "<cmd>Lspsaga code_action<CR>")
        end,
    }, _config or {})
end

require("lspconfig").gopls.setup(config())

require("lspconfig").tsserver.setup(config())

require("lspconfig").vuels.setup(config())

require("lspconfig").rust_analyzer.setup(config({
    cmd = { "rustup", "run", "stable", "rust-analyzer" },
}))

require("lspconfig").sumneko_lua.setup(config({
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

-- Project structure
require("symbols-outline").setup()

-- Snippets
local snippets_paths = function()
	local plugins = { "friendly-snippets" }
	local paths = {}
	local path
	local root_path = vim.env.HOME .. "/.vim/plugged/"
	for _, plug in ipairs(plugins) do
		path = root_path .. plug
		if vim.fn.isdirectory(path) ~= 0 then
			table.insert(paths, path)
		end
	end
	return paths
end

require("luasnip.loaders.from_vscode").lazy_load({
	paths = snippets_paths(),
	include = nil, -- Load all languages
	exclude = {},
})
