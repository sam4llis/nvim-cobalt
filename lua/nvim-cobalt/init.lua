if vim.fn.has('nvim-0.7.0') ~= 1 then
  vim.api.nvim_err_writeln("The plugin `nvim-cobalt` requires Neovim 0.7.0.")
  return
end

local M = {}
local utils = require('nvim-treesitter.ts_utils')

local BOOLEAN_ALTERNATE = vim.tbl_add_reverse_lookup({
  ['True'] = 'False',
  ['true'] = 'false',
})


M.toggle = function ()
  local winnr = 0 -- Perform actions in the current window.
  local node = utils.get_node_at_cursor(winnr) -- Node data at the initial cursor position.

  -- Recursively search up the node tree for actionable node types.
  while node ~= nil do
    if node:type() == 'string' then
      M.string_toggle(node)
      break
    end

    if node:type() == 'true' or node:type() == 'false' then
      M.boolean_toggle(node)
      break
    end

    node = node:parent()
  end

  if not node then
    vim.api.nvim_err_writeln('No alternate found')
    return
  end
end


M.string_toggle = function (node)
  local winnr = 0

  -- Store initial cursor position.
  local irow, icol = unpack(vim.api.nvim_win_get_cursor(winnr))

  -- Get positional data on the string node.
  local srow, scol, erow, ecol = utils.get_vim_range({ node:range() })

  -- Position the cursor at the first position of the string node.
  vim.fn.setcursorcharpos(srow, scol)

  -- Get text as a string from the node.
  local text = vim.treesitter.query.get_node_text(node, winnr)

  if vim.startswith(text, 'f') then
    vim.cmd('normal x')
    -- Move cursor -1 if `f` is removed on the same line as the user's initial position.
    if srow == irow then
      icol = icol - 1
    end
  else
    vim.cmd('normal if')
    -- Move cursor +1 if `f` is added on the same line as the user's initial position.
    if srow == irow then
      icol = icol + 1
    end
  end

  -- Move the user's cursor back to its initial position.
  vim.api.nvim_win_set_cursor(winnr, { irow, icol })
end


M.boolean_toggle = function (node)
  local winnr = 0

  -- Store initial cursor position.
  local irow, icol = unpack(vim.api.nvim_win_get_cursor(winnr))
  -- Get positional data on the string node.
  local srow, scol, ecol, erow = utils.get_vim_range({ node:range() })

  -- Get text as a string from the node.
  local text = vim.treesitter.query.get_node_text(node, winnr)

  vim.cmd('normal ciw' .. BOOLEAN_ALTERNATE[ text ])

  -- Move the user's cursor back to its initial position.
  vim.api.nvim_win_set_cursor(winnr, { irow, icol })
end

return M
