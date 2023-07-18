return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
    },
    keys = {
        { "<Up>",           function() require("dap").continue() end },
        { "<Down>",         function() require("dap").step_over() end },
        { "<Right>",        function() require("dap").step_into() end },
        { "<Left>",         function() require("dap").step_out() end },
        { "<leader>b",      function() require("dap").toggle_breakpoint() end },
        { "<leader>B",      function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end },
        { "<leader>lp",     function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end },
        { "<leader>dr",     function() require("dap").repl.open() end },
        { "<leader>rc",     function() require("dap").repl.run_to_cursor() end },
        { "<leader><Left>", function() require("dapui").toggle(1) end },
        { "<leader><Down>", function() require("dapui").toggle(2) end },
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        local virtualText = require("nvim-dap-virtual-text")

        virtualText.setup()
        dapui.setup()

        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open(1)
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end
    end
}
