require("telescope").setup {
  extensions = {
    file_browser = {
      initial_mode = "normal",
      hijack_netrw = true,
    },
  },
}

require("telescope").load_extension("file_browser")
