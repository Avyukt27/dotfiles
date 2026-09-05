return {
  'folke/tokyonight.nvim',
  priority = 1000,
  lazy = false,
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('tokyonight').setup {
      styles = {
        comments = { italic = true },
      },
    }
    vim.cmd.colorscheme 'tokyonight-storm'
  end,
}
