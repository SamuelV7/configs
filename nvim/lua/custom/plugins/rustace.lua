return {
  'mrcjkb/rustaceanvim',
  version = '^6', -- Recommended
  lazy = false, -- This plugin is already lazy
  init = function()
    vim.g.rustaceanvim = {
      tools = {
        code_actions = {
          -- Fall back to the normal selector when rust-analyzer does not send
          -- grouped code actions.
          ui_select_fallback = true,
        },
      },
      dap = {
        adapter = function()
          local codelldb = vim.env.CODELLDB_PATH
          if not codelldb or codelldb == '' then
            return false
          end

          return {
            type = 'server',
            port = '${port}',
            executable = {
              command = codelldb,
              args = { '--port', '${port}' },
            },
          }
        end,
      },
      server = {
        on_attach = function(_, bufnr)
          -- rust-analyzer can send grouped code actions. The built-in
          -- vim.lsp.buf.code_action() does not handle those as well as
          -- rustaceanvim's RustLsp command.
          vim.keymap.set('n', '<leader>ca', function()
            vim.cmd.RustLsp 'codeAction'
          end, { buffer = bufnr, desc = 'Rust Code Action' })
        end,
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
