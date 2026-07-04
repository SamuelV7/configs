return {
  'numToStr/Comment.nvim',
  opts = {
    -- Comment.nvim uses treesitter to resolve embedded-language commentstrings.
    -- On newer Neovim, get_parser() may return nil instead of throwing when a
    -- parser is missing, which makes Comment.nvim crash with `[Comment.nvim] nil`.
    -- Keep treesitter support when available, otherwise fall back to the native
    -- filetype commentstring.
    pre_hook = function(ctx)
      local ok, parser = pcall(vim.treesitter.get_parser, vim.api.nvim_get_current_buf())
      if ok and parser then
        local ok_cstr, cstr = pcall(require('Comment.ft').calculate, ctx)
        if ok_cstr and cstr then
          return cstr
        end
      end

      return vim.bo.commentstring
    end,
  },
}
