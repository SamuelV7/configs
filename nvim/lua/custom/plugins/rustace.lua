return {
  'mrcjkb/rustaceanvim',
  version = '^6', -- Recommended
  lazy = false, -- This plugin is already lazy
  init = function()
    vim.g.rustaceanvim = {
      server = {
        -- rustaceanvim's server-status handler currently calls
        -- vim.lsp.get_buffers_by_client_id(), which is deprecated in newer Neovim.
        -- This no-op handler avoids the warning until rustaceanvim updates.
        handlers = {
          ['experimental/serverStatus'] = function() end,
        },
      },
    }
  end,
}
