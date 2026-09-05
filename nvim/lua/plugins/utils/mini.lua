return {
  'echasnovski/mini.nvim',
  config = function()
    require('mini.ai').setup { n_lines = 500 }
    require('mini.surround').setup()
    require('mini.sessions').setup { filetype = { exclude = { 'snacks_picker_list' } } }
  end,
}
