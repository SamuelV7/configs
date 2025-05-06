-- lua/custom/plugins/mason-dap.lua
return {
  'jay-babu/mason-nvim-dap.nvim',
  dependencies = {
    'williamboman/mason.nvim', -- Mason core
    'mfussenegger/nvim-dap', -- nvim-dap itself
  },
  cmd = { 'DapInstall', 'DapUninstall' },
  opts = {
    -- List of adapters to install if missing
    ensure_installed = { 'python', 'delve', 'codelldb' },
    -- Automatically install any DAP adapters you set up via DAP
    automatic_installation = true,
    -- Empty handlers = “auto‑setup everything with defaults”
    handlers = {},
  },
  config = function(_, opts)
    -- 1) Bootstrap Mason
    require('mason').setup()
    -- 2) Wire up all adapters & configs in one go
    require('mason-nvim-dap').setup(opts)
  end,
}
