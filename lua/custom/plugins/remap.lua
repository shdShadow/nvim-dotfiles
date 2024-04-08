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
  --LSPSAGA HOVER_DOC
  vim.api.nvim_set_keymap('n', '<Leader>dd', ':Lspsaga hover_doc<CR>', { noremap = true, silent = true }),

  --TERMINAL
  vim.api.nvim_set_keymap('n', "<leader>tt", ":ToggleTerm<CR>", { noremap = true, silent = true }),
  --TMUX
  vim.api.nvim_set_keymap('n', "<C-h>",":TmuxNavigateLeft<CR>", {noremap = true, silent = true} ),
  vim.api.nvim_set_keymap('n', "<C-l>",":TmuxNavigateRight<CR>", {noremap = true, silent = true} ),
  vim.api.nvim_set_keymap('n', "<C-j>",":TmuxNavigateDown<CR>", {noremap = true, silent = true} ),
  vim.api.nvim_set_keymap('n', "<C-k>",":TmuxNavigateUp<CR>", {noremap = true, silent = true} ),
  --RESIZE WINDOWS
  vim.api.nvim_set_keymap('n', '<A-Up>', ':all resize +2<CR>', { noremap = true, silent = true }),
vim.api.nvim_set_keymap('n', '<A-Down>', ':all resize -2<CR>', { noremap = true, silent = true }),
vim.api.nvim_set_keymap('n', '<A-Left>', ':all vertical resize +2<CR>', { noremap = true, silent = true }),
vim.api.nvim_set_keymap('n', '<A-Right>', ':all vertical resize -2<CR>', { noremap = true, silent = true }),


--VIMTEx
vim.api.nvim_set_keymap('n', '<Leader>ll', ':VimtexCompile<CR>', { noremap = true, silent = true }),
vim.api.nvim_set_keymap('n', '<Leader>lc', ':VimtexClean<CR>', { noremap = true, silent = true }),



}
