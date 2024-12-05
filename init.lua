--[[
=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================

Kickstart.nvim is *not* a distribution.

Kickstart.nvim is a template for your own configuration.
  The goal is that you can read every line of code, top-to-bottom, understand
  what your configuration is doing, and modify it to suit your needs.

  Once you've done that, you should start exploring, configuring and tinkering to
  explore Neovim!

  If you don't know anything about Lua, I recommend taking some time to read through
  a guide. One possible example:
  - https://learnxinyminutes.com/docs/lua/


  And then you can explore or search through `:help lua-guide`
  - https://neovim.io/doc/user/lua-guide.html


Kickstart Guide:

I have left several `:help X` comments throughout the init.lua
You should run that command and read that help section for more information.

In addition, I have some `NOTE:` items throughout the file.
These are for you, the reader to help understand what is happening. Feel free to delete
them once you know what you're doing, but they should serve as a guide for when you
are first encountering a few different constructs in your nvim config.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now :)
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Install `lazy.nvim` plugin manager ]]
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- [[ Configure plugins ]]
-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },
  --DAP
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {},
    }
  },
  --ROSE PINE
  {
    --{ 'rose-pine/neovim', name = 'rose-pine' },
  },
  {
    { "EdenEast/nightfox.nvim" } -- lazy
  },
  {
    'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
    --config = function()
        --require 'nordic' .load()
    --end
},
  --GRUVBOX
  {
    { "ellisonleao/gruvbox.nvim", priority = 1000, config = true, opts = ... },
  },
  --VSCODE THEME
  {
    "askfiy/visual_studio_code",
    priority = 100,
    --config = function()
      --vim.cmd([[colorscheme visual_studio_code]])
    --end,
  },
  --VIMTEX
  {
    "lervag/vimtex",
    ft = "tex",
    config = function()
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_compiler_method = 'latexmk'
    end,
  },

  --TRANSPARENCY
  {
    "xiyaowong/transparent.nvim",
  },
  --LUALINE EXTENSION FOR CLOCK
  {
    "archibate/lualine-time",
  },
  --NEOFORMAT
  {
    "sbdchd/neoformat",
  },
  --TERMINAL
  {
    { 'akinsho/toggleterm.nvim', version = "*", config = true },
  },
  --COMPILER
  {
    "krady21/compiler-explorer.nvim"
  },
  --NEOSCROLL
  {
    "declancm/cinnamon.nvim",
    config = function()
      require('cinnamon').setup()
    end,
  },
  {
    'andweeb/presence.nvim',
  },
  --COPILOT
  {
    "github/copilot.vim",
  },
  --RUST-TOOLS
  {
    'neovim/nvim-lspconfig',
    'simrat39/rust-tools.nvim',

    'nvim-lua/plenary.nvim',
    'mfussenegger/nvim-dap',
  },
  --HIGHLIGHT COMMENT
  {
    "leon-richardt/comment-highlights.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
    cmd = "CHToggle",
    keys = {
      {
        "<leader>cc",
        function() require("comment-highlights").toggle() end,
        desc = "Toggle comment highlighting"
      },
    },
  },
  --TMUX
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  --SIGNATURE
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts) require 'lsp_signature'.setup(opts) end
  },
  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },
  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim',  opts = {} },
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })

        -- don't override the built-in and fugitive keymaps
        local gs = package.loaded.gitsigns
        vim.keymap.set({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
        vim.keymap.set({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })
      end,
    },
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    --opts = {
    --options = {
    --icons_enabled = false,
    --theme = '',
    --component_separators = '|',
    --section_separators = '',
    --},
    --},
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {},
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --    Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  { import = 'custom.plugins' },
}, {})

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
  -- Use the current buffer's path as the starting point for the git search
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  -- If the buffer is not associated with a file, return nil
  if current_file == "" then
    current_dir = cwd
  else
    -- Extract the directory from the current file's path
    current_dir = vim.fn.fnamemodify(current_file, ":h")
  end

  -- Find the Git root directory from the current file's path
  local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
  if vim.v.shell_error ~= 0 then
    print("Not a git repository. Searching on current working directory")
    return cwd
  end
  return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
  local git_root = find_git_root()
  if git_root then
    require('telescope.builtin').live_grep({
      search_dirs = { git_root },
    })
  end
end

vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
  require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash' },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = false,

    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        scope_incremental = '<c-s>',
        node_decremental = '<M-space>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>A'] = '@parameter.inner',
        },
      },
    },
  }
end, 0)

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- document existing key chains
require('which-key').register {
  ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
  ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
  ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
  ['<leader>h'] = { name = 'More git', _ = 'which_key_ignore' },
  ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
  ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
  ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
}

-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
require("neodev").setup({
  -- add any options here, or leave empty to use the default settings
})

-- then setup your lsp server as usual
local lspconfig = require('lspconfig')
-- example to setup lua_ls and enable call snippets
lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace"
      }
    }
  }
})
require('mason').setup()
require('mason-lspconfig').setup()

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  -- tsserver = {},
  -- html = { filetypes = { 'html', 'twig', 'hbs'} },

  intelephense = { filetypes = { 'php', }, tabstop=4 },
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
capabilities.offsetEncoding = { "utf-16"}

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end,
}

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local kind_icons = {
  Text = "",
  Method = "󰆧",
  Function = "󰊕",
  Constructor = "",
  Field = "󰇽",
  Variable = "󰂡",
  Class = "󰠱",
  Interface = "",
  Module = "",
  Property = "󰜢",
  Unit = "",
  Value = "󰎠",
  Enum = "",
  Keyword = "󰌋",
  Snippet = "",
  Color = "󰏘",
  File = "󰈙",
  Reference = "",
  Folder = "󰉋",
  EnumMember = "",
  Constant = "󰏿",
  Struct = "",
  Event = "",
  Operator = "󰆕",
  TypeParameter = "󰅲",
}
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  sources = {
    name = 'nvim_lsp_signature_help',
  },
  formatting = {
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      -- Source
      vim_item.abbr = string.sub(vim_item.abbr, 1, 20)
      return vim_item
    end
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
  window = {
    completion = {
      border = "rounded",
      scrollbar = false,
    },
    documentation = {
      border = "rounded",
    },
  },
}

--function FormatOnSave()
--vim.cmd(':Format')
--end

-- Associa la funzione all'autocomando BufWritePost
--vim.api.nvim_exec([[
--autocmd BufWritePost * lua FormatOnSave()
--]], false)
--OPTIONS
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
--vim.opt.expandtab = true
vim.g.copilot_assume_mapped = true

vim.cmd([[
  autocmd FileType make set noexpandtab
]])

--vim.cmd.colorscheme "gruvbox"
--vim.cmd('autocmd BufWinLeave * mkview')
--vim.cmd('autocmd BufWinEnter * silent loadview')
vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
  pattern = { "*.*" },
  desc = "save view (folds), when closing file",
  command = "mkview",
})
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  pattern = { "*.*" },
  desc = "load view (folds), when opening file",
  command = "silent! loadview"
})
vim.opt.smartindent = true
vim.opt.scrolloff = 10

require("presence").setup({
  -- General options
  auto_update         = true,                         -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
  neovim_image_text   = "The One True Text Editor",   -- Text displayed when hovered over the Neovim image
  main_image          = "neovim",                     -- Main image display (either "neovim" or "file")
  client_id           = "1125152218073534485",        -- Use your own Discord application client id (not recommended)
  log_level           = nil,                          -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
  debounce_timeout    = 10,                           -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
  enable_line_number  = false,                        -- Displays the current line number instead of the current project
  blacklist           = {},                           -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
  buttons             = true,                         -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)
  file_assets         = {},                           -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
  show_time           = true,                         -- Show the timer

  -- Rich Presence text options
  editing_text        = "Editing %s",           -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
  file_explorer_text  = "Browsing %s",          -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
  git_commit_text     = "Committing changes",   -- Format string rendered when committing changes in git (either string or function(filename: string): string)
  plugin_manager_text = "Managing plugins",     -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
  reading_text        = "Reading %s",           -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
  workspace_text      = "Working on %s",        -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
  line_number_text    = "Line %s out of %s",    -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
})
require('presence'):connect()
require "battery".setup({})
vim.opt.pumheight = 10;
vim.o.pumwidth = 80;
vim.g.intelephense_setup = {
  intelephense = {
    root_path = vim.fn.expand('%:p:h'),
  },
}

-- init.lua or init.vim (NeoVim's init file)


local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})




cfg = {
  debug = false,                                              -- set to true to enable debug logging
  log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
  -- default is  ~/.cache/nvim/lsp_signature.log
  verbose = false,                                            -- show debug line number

  bind = true,                                                -- This is mandatory, otherwise border config won't get registered.
  -- If you want to hook lspsaga or other signature handler, pls set to false
  doc_lines = 100,                                            -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
  -- set to 0 if you DO NOT want any API comments be shown
  -- This setting only take effect in insert mode, it does not affect signature help in normal
  -- mode, 10 by default

  max_height = 16,                       -- max height of signature floating_window
  max_width = 80,                        -- max_width of signature floating_window, line will be wrapped if exceed max_width
  -- the value need >= 40
  wrap = true,                           -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long
  floating_window = true,                -- show hint in a floating window, set to false for virtual text only mode

  floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
  -- will set to true when fully tested, set to false will use whichever side has more space
  -- this setting will be helpful if you do not want the PUM and floating win overlap

  floating_window_off_x = 1, -- adjust float windows x position.
  -- can be either a number or function
  floating_window_off_y = 0, -- adjust float windows y position. e.g -2 move window up 2 lines; 2 move down 2 lines
  -- can be either number or function, see examples

  close_timeout = 4000, -- close floating window after ms when laster parameter is entered
  fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
  hint_enable = true, -- virtual hint enable
  hint_prefix = "🐼 ", -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
  hint_scheme = "String",
  hint_inline = function() return false end, -- should the hint be inline(nvim 0.10 only)?  default false
  -- return true | 'inline' to show hint inline, return 'eol' to show hint at end of line, return false to disable
  -- return 'right_align' to display hint right aligned in the current line
  hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
  handler_opts = {
    border = "rounded"                          -- double, rounded, single, shadow, none, or a table of borders
  },

  always_trigger = false,                  -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

  auto_close_after = nil,                  -- autoclose signature float win after x sec, disabled if nil.
  extra_trigger_chars = {},                -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
  zindex = 200,                            -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

  padding = '',                            -- character to pad on left and right of signature can be ' ', or '|'  etc

  transparency = nil,                      -- disabled by default, allow floating win transparent value 1~100
  shadow_blend = 36,                       -- if you using shadow as border use this set the opacity
  shadow_guibg = 'Black',                  -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
  timer_interval = 200,                    -- default timer check interval set to lower value if you want to reduce latency
  toggle_key = '<M-x>',                    -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
  toggle_key_flip_floatwin_setting = true, -- true: toggle floating_windows: true|false setting after toggle key pressed
  -- false: floating_windows setup will not change, toggle_key will pop up signature helper, but signature
  -- may not popup when typing depends on floating_window setting

  select_signature_key = nil, -- cycle to next signature, e.g. '<M-n>' function overloading
  move_cursor_key = nil,      -- imap, use nvim_set_current_win to move cursor between current win and floating
}

-- recommended:
require 'lsp_signature'.setup(cfg, bufnr)    -- no need to specify bufnr if you don't use toggle_key
require 'lsp_signature'.on_attach(cfg, bufnr) --
-- You can also do this inside lsp on_attach
-- note: on_attach deprecated
-- You can also do this inside lsp on_attach
-- note: on_attach deprecated
--SOMETHING FOR RUST TOOLS
require('rust-tools').inlay_hints.enable()



--VIMTEX MAYBE
vim.cmd("filetype plugin on")
vim.cmd("filetype indent on")

--vim.cmd("colorscheme duskfox")


-- Assicurati di aver installato 'luasnip'
local ls = require('luasnip')

-- Carica tutti i tuoi snippet
-- Assicurati di aver installato 'luasnip' e 'luasnip/loaders/from_vscode'
local ls = require('luasnip')
local lsp = require('luasnip/loaders/from_vscode')

-- Carica gli snippet predefiniti
lsp.load({ include = { "html" } })

-- Imposta gli snippet HTML per i file PHP
ls.filetype_extend("php", { "html" })
vim.cmd("colorscheme catppuccin-mocha")



-- Disable arrow keys in normal mode
vim.api.nvim_set_keymap('n', '<Up>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Down>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Left>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Right>', '<Nop>', { noremap = true, silent = true })

-- Disable arrow keys in insert mode
vim.api.nvim_set_keymap('i', '<Up>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<Down>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<Left>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<Right>', '<Nop>', { noremap = true, silent = true })

-- Disable arrow keys in visual mode
vim.api.nvim_set_keymap('v', '<Up>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<Down>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<Left>', '<Nop>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<Right>', '<Nop>', { noremap = true, silent = true })

vim.cmd [[highlight LineNr guifg=#FFFFFF]]




-- GO
 require('dap-go').setup {
  -- Additional dap configurations can be added.
  -- dap_configurations accepts a list of tables where each entry
  -- represents a dap configuration. For more details do:
  -- :help dap-configuration
  dap_configurations = {
    {
      -- Must be "go" or it will be ignored by the plugin
      type = "go",
      name = "Attach remote",
      mode = "remote",
      request = "attach",
    },
  },
  -- delve configurations
  delve = {
    -- the path to the executable dlv which will be used for debugging.
    -- by default, this is the "dlv" executable on your PATH.
    path = "/home/shdshadow/go/bin/dlv",
    -- time to wait for delve to initialize the debug session.
    -- default to 20 seconds
    initialize_timeout_sec = 20,
    -- a string that defines the port to start delve debugger.
    -- default to string "${port}" which instructs nvim-dap
    -- to start the process in a random available port
    port = "${port}",
    -- additional args to pass to dlv
    args = {},
    -- the build flags that are passed to delve.
    -- defaults to empty string, but can be used to provide flags
    -- such as "-tags=unit" to make sure the test suite is
    -- compiled during debugging, for example.
    -- passing build flags using args is ineffective, as those are
    -- ignored by delve in dap mode.
    -- avaliable ui interactive function to prompt for arguments get_arguments
    build_flags = {},
    -- whether the dlv process to be created detached or not. there is
    -- an issue on Windows where this needs to be set to false
    -- otherwise the dlv server creation will fail.
    -- avaliable ui interactive function to prompt for build flags: get_build_flags
    detached = vim.fn.has("win32") == 0,
    -- the current working directory to run dlv from, if other than
    -- the current working directory.
    cwd = nil,
  },
  -- options related to running closest test
  tests = {
    -- enables verbosity when running the test.
    verbose = false,
  },
}

