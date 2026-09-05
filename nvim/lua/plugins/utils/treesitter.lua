return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  lazy = false,
  dependencies = {
    'nvim-treesitter/nvim-treesitter-context',
  },
  config = function()
    local treesitter = require 'nvim-treesitter'
    local ensure_installed = require 'configs.treesitter.langs'
    require('nvim-treesitter.config').setup {
      install_dir = vim.fn.stdpath 'data' .. '/site',
      highlight = {
        enable = true,
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          },
        },
      },
    }
    treesitter.install(ensure_installed)
    require 'configs.treesitter.plugins'
  end,
}
