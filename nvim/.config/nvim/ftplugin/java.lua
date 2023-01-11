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
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    init_options = {
        bundles = {}
    },
}

require('jdtls').start_or_attach(config)

vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>")
vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end)
vim.keymap.set("n", "gt", function() vim.lsp.buf.type_definition() end)
vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end)
vim.keymap.set("n", "gu", "<cmd>Lspsaga lsp_finder<CR>")
vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>")
vim.keymap.set("n", "gr", "<cmd>Lspsaga rename<CR>")
vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end)
vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>")

