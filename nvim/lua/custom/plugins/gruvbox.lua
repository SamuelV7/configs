return {
  'ellisonleao/gruvbox.nvim',
  lazy = false,
  priority = 1000,
  opts = {
    -- contrast = 'hard',
    terminal_colors = true,
    contrast = '',
    palette_overrides = {
      dark0 = '#0b0b0b', -- <== custom deep dark background
    },
    overrides = {
      Normal = { bg = '#0b0b0b' }, -- set default editor background
    },
  },
  config = function()
    vim.o.background = 'dark' -- or "light" for light mode
    -- vim.cmd [[colorscheme gruvbox]]
  end,
  opts = ...,
}
