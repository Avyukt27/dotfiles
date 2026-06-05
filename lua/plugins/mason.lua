return {
  { 'mason-org/mason.nvim', opts = {} },
  { 'mason-org/mason-lspconfig.nvim', opts = {} },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = { 'mason-org/mason.nvim' },
    opts = {
      ensure_installed = require 'configs.tools',
      run_on_start = true,
    },
  },
}
