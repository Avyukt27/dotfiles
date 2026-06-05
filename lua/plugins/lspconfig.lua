return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'mason-org/mason.nvim', opts = {} },
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    'saghen/blink.cmp',
  },
  config = function()
    require 'configs.diagnostics'

    local servers = require 'configs.servers'
    local tools = require 'configs.tools'

    for _, tool in ipairs(tools) do
      if vim.lsp.config[tool] then
        local opts = servers[tool] or {}
        vim.lsp.config(tool, opts)
      end
    end
  end,
}
