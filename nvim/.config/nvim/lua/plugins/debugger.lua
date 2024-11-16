return {
  'mfussenegger/nvim-dap',
  dependencies = {
    { 'rcarriga/nvim-dap-ui' },
    { 'theHamsta/nvim-dap-virtual-text' },
    {
      'leoluz/nvim-dap-go',
      config = function()
        require('dap-go').setup()
      end,
      keys = {
        {
          '<leader>dt',
          function()
            require('dap-go').debug_test()
          end,
          desc = '[D]ebug go [T]est',
        },
      },
    },
  },
  keys = {
    {
      '<Up>',
      function()
        require('dap').continue()
      end,
      desc = 'Continue debug',
    },
    {
      '<Down>',
      function()
        require('dap').step_over()
      end,
      desc = 'Step over debug',
    },
    {
      '<Right>',
      function()
        require('dap').step_into()
      end,
      desc = 'Step into debug',
    },
    {
      '<Left>',
      function()
        require('dap').step_out()
      end,
      desc = 'Step out debug',
    },
    {
      '<leader>b',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Set breakpoint debug',
    },
    {
      '<leader>B',
      function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = 'Set conditional breakpoint debug',
    },
    {
      '<leader>lp',
      function()
        require('dap').set_breakpoint(nil, nil, vim.fn.input 'Log point message: ')
      end,
      desc = 'Set log point debug',
    },
    {
      '<leader>dr',
      function()
        require('dap').repl.open()
      end,
    },
    {
      '<leader>rc',
      function()
        require('dap').repl.run_to_cursor()
      end,
    },
    {
      '<leader><Left>',
      function()
        require('dapui').toggle(1)
      end,
    },
    {
      '<leader><Down>',
      function()
        require('dapui').toggle(2)
      end,
    },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    local virtualText = require 'nvim-dap-virtual-text'

    virtualText.setup()
    dapui.setup()

    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open(1)
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close()
    end
  end,
}
