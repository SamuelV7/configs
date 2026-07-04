-- DAP adapters are installed by Nix/Home Manager instead of Mason so they work
-- on NixOS without dynamic-loader shims.
return {
  'jay-babu/mason-nvim-dap.nvim',
  enabled = false,
}
