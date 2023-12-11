--NEOTREE
return {
  vim.api.nvim_set_keymap('n', '<Leader>nto', ':Neotree<CR>', { noremap = true, silent = true }),
  vim.api.nvim_set_keymap('n', '<Leader>ntc', ':Neotree close<CR>', { noremap = true, silent = true }),

  --BARBAR
  vim.api.nvim_set_keymap('n', '<C-Right>', ':BufferNext<CR>', { noremap = true, silent = true }),
  vim.api.nvim_set_keymap('n', '<C-Left>', ":BufferPrevious<CR>", { noremap = true, silent = true }),
  vim.api.nvim_set_keymap('n', '<C-A-Left>', ':BufferMovePrevious<CR>', { noremap = true, silent = true }),
  vim.api.nvim_set_keymap('n', '<C-A-Right>', ':BufferMoveNext<CR>', { noremap = true, silent = true }),

  --DAP
  vim.api.nvim_set_keymap('n', "<leader>db", ':DapToggleBreakpoint <CR>', { noremap = true, silent = true }),
  vim.api.nvim_set_keymap('n', "<leader>dr", ':DapContinue <CR>', { noremap = true, silent = true }),
  vim.api.nvim_set_keymap('n', "<F10>", ":DapStepOver<CR>", { noremap = true, silent = true }),
  vim.api.nvim_set_keymap('n', "<F11>", ":DapStepInto<CR>", { noremap = true, silent = true }),

  --TERMINAL
  vim.api.nvim_set_keymap('n', "<leader>tt", ":ToggleTerm<CR>", { noremap = true, silent = true }),
  --TMUX
  vim.api.nvim_set_keymap('n', "<C-h>",":TmuxNavigateLeft<CR>", {noremap = true, silent = true} ),
  vim.api.nvim_set_keymap('n', "<C-l>",":TmuxNavigateRight<CR>", {noremap = true, silent = true} ),
  vim.api.nvim_set_keymap('n', "<C-j>",":TmuxNavigateDown<CR>", {noremap = true, silent = true} ),
  vim.api.nvim_set_keymap('n', "<C-k>",":TmuxNavigateUp<CR>", {noremap = true, silent = true} ),
}
