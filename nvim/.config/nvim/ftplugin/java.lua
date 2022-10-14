local Remap = require("mdonnart.keymap")
local inoremap = Remap.inoremap
local nnoremap = Remap.nnoremap

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local workspace_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

local config = {
    cmd = {
        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xms1g',
        '-javaagent:/home/mdonnart/.local/jars/lombok.jar',
        '-Xbootclasspath/a:/home/mdonnart/.local/jars/lombok.jar',
        '-jar', '/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
        '-configuration', '/usr/share/java/jdtls/config_linux',
        '-data', vim.fn.expand('~/.cache/jdtls-workspace') .. workspace_dir,
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
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
