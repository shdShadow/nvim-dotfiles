return {
  "romgrk/barbar.nvim",
  dependencies = {
    'lewis6991/gitsigns.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  init = function() vim.g.barbar_auto_setup = false end,
  opts = {
    icons = {
      buffer_index = true,
      buffer_number = false,
      diagnostics = {
        [vim.diagnostic.severity.ERROR] = { enabled = true, icon = " " },
        [vim.diagnostic.severity.WARN] = { enabled = false },
        [vim.diagnostic.severity.INFO] = { enabled = false },
        [vim.diagnostic.severity.HINT] = { enabled = true },
      },
      filetype = {
        custom_colors = false,
        enabled = true,
      },
      alternate = { filetype = { enabled = false } },
      current = { buffer_index = true },
      inactive = { button = '×' },
      visible = { modified = { buffer_number = false } },
    },
    maximum_padding = 1,
    minimum_padding = 1,
    maximum_length = 20,
    minimum_length = 0,
    semantic_letters = true,
    no_name_title = "Unnamed crap",
  }
}
