-- Alternate boolean {True | False} and string {f'' | ''} nodes.
vim.api.nvim_buf_create_user_command(
  0,
  'CAlternate',
  function()
    require('nvim-cobalt').toggle()
  end,
  {}
)
