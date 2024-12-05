return {
  "mfussenegger/nvim-dap", -- or the appropriate plugin for 'nvim-dap'
  config = function()
    local dap = require("dap")

    -- Lua DAP configuration
    dap.configurations.lua = {
      {
        name = 'Current file (local-lua-dbg, lua)',
        type = 'local-lua',
        request = 'launch',
        cwd = '${workspaceFolder}',
        program = {
          lua = 'lua',
          file = '${file}',
        },
        args = {},
      },
    }

    -- Lua DAP adapter setup
    dap.adapters["local-lua"] = {
      type = "executable",
      command = "local-lua-dbg",
      enrich_config = function(config, on_config)
        if not config["extensionPath"] then
          local c = vim.deepcopy(config)
          -- 💀 Ensure the extensionPath is set correctly
          c.extensionPath = "/usr/lib/node_modules/local-lua-debugger-vscode/"
          on_config(c)
        else
          on_config(config)
        end
      end,
    }
  end,
}

