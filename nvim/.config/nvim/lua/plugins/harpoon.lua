return {
  'ThePrimeagen/harpoon',
  keys = {
    {
      '<leader>a',
      function()
        require('harpoon.mark').add_file()
      end,
      desc = '[A]dd file to Harpoon',
    },
    {
      '<C-e>',
      function()
        require('harpoon.ui').toggle_quick_menu()
      end,
      desc = '[E]dit files in Harpoon',
    },
    {
      '<C-h>',
      function()
        require('harpoon.ui').nav_file(1)
      end,
      desc = '[C-h] Go to first harpoon file',
    },
    {
      '<C-j>',
      function()
        require('harpoon.ui').nav_file(2)
      end,
      desc = '[C-j] Go to second harpoon file',
    },
    {
      '<C-k>',
      function()
        require('harpoon.ui').nav_file(3)
      end,
      desc = '[C-k] Go to third harpoon file',
    },
    {
      '<C-l>',
      function()
        require('harpoon.ui').nav_file(4)
      end,
      desc = '[C-l] Go to fourth harpoon file',
    },
  },
}
