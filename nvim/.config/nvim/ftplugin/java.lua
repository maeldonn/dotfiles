local Remap = require("mdonnart.keymap")
local inoremap = Remap.inoremap
local nnoremap = Remap.nnoremap

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local workspace_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

local config = {
    cmd = {
        'jdtls',
        '-configuration ~/.cache/jdtls',
        '-data', vim.fn.expand('~/.cache/jdtls-workspace') .. workspace_dir,
    },
    root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew', 'pom.xml'}),
    capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities),
    init_options = {
        bundles = {}
    },
}

require('jdtls').start_or_attach(config)

nnoremap("K", function() vim.lsp.buf.hover() end)
nnoremap("gd", function() vim.lsp.buf.definition() end)
nnoremap("gt", function() vim.lsp.buf.type_definition() end)
nnoremap("gi", function() vim.lsp.buf.implementation() end)
nnoremap("gu", function() vim.lsp.buf.references() end)
nnoremap("[d", function() vim.diagnostic.goto_next() end)
nnoremap("]d", function() vim.diagnostic.goto_prev() end)
nnoremap("gr", function() vim.lsp.buf.rename() end)
inoremap("<C-h>", function() vim.lsp.buf.signature_help() end)
nnoremap("<leader>ca", function() vim.lsp.buf.code_action() end)
