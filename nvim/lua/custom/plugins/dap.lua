local function get_args()
  local args = vim.fn.input 'Arguments: '
  return vim.split(args, ' ', { trimempty = true })
end

local function adapter_command(env_var, executable)
  local env_path = vim.env[env_var]
  if env_path and env_path ~= '' then
    return env_path
  end

  local path = vim.fn.exepath(executable)
  return path ~= '' and path or executable
end

return {
  'mfussenegger/nvim-dap',
  recommended = true,
  desc = 'Debugging support. Requires language specific adapters to be configured. (see lang extras)',

  dependencies = {
    'rcarriga/nvim-dap-ui',
    -- virtual text for the debugger
    {
      'theHamsta/nvim-dap-virtual-text',
      opts = {},
    },
  },

  -- stylua: ignore
  keys = {
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>dc", function() require("dap").continue() end, desc = "Run/Continue" },
    { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
    { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
    { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
    { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
    { "<leader>dj", function() require("dap").down() end, desc = "Down" },
    { "<leader>dk", function() require("dap").up() end, desc = "Up" },
    { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
    { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
    { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
    { "<leader>dP", function() require("dap").pause() end, desc = "Pause" },
    { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    { "<leader>ds", function() require("dap").session() end, desc = "Session" },
    { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
    { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
  },

  config = function()
    local dap = require 'dap'

    dap.adapters.codelldb = {
      type = 'server',
      port = '${port}',
      executable = {
        command = adapter_command('CODELLDB_PATH', 'codelldb'),
        args = { '--port', '${port}' },
      },
    }

    local codelldb_configurations = {
      {
        name = 'Debug executable',
        type = 'codelldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
      },
    }

    dap.configurations.rust = codelldb_configurations
    dap.configurations.c = codelldb_configurations
    dap.configurations.cpp = codelldb_configurations

    dap.adapters.python = {
      type = 'executable',
      command = adapter_command('DEBUGPY_ADAPTER_PATH', 'debugpy-adapter'),
    }

    dap.configurations.python = {
      {
        type = 'python',
        request = 'launch',
        name = 'Launch file',
        program = '${file}',
        pythonPath = function()
          local venv = vim.env.VIRTUAL_ENV
          if venv and venv ~= '' then
            return venv .. '/bin/python'
          end

          local python = vim.fn.exepath 'python3'
          return python ~= '' and python or 'python3'
        end,
      },
    }

    dap.adapters.delve = {
      type = 'server',
      port = '${port}',
      executable = {
        command = adapter_command('DLV_PATH', 'dlv'),
        args = { 'dap', '-l', '127.0.0.1:${port}' },
      },
    }

    dap.configurations.go = {
      {
        type = 'delve',
        name = 'Debug file',
        request = 'launch',
        program = '${file}',
      },
      {
        type = 'delve',
        name = 'Debug package',
        request = 'launch',
        program = '${fileDirname}',
      },
      {
        type = 'delve',
        name = 'Debug test',
        request = 'launch',
        mode = 'test',
        program = '${fileDirname}',
      },
    }

    -- highlight the current stopped line
    vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })
  end,
}
