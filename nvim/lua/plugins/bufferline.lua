return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('bufferline').setup {
      options = {
        separator_style = 'slant',
        diagnostics = 'nvim_lsp',
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local diag_config = vim.diagnostic.config()
          local signs = diag_config and diag_config.signs and diag_config.signs.text or {}

          local severity_map = {
            error = vim.diagnostic.severity.ERROR,
            warning = vim.diagnostic.severity.WARN,
            info = vim.diagnostic.severity.INFO,
            hint = vim.diagnostic.severity.HINT,
          }

          local s = ' '
          for type, num in pairs(diagnostics_dict) do
            local sev = severity_map[type]
            local icon = (signs and signs[sev]) or (type:sub(1, 1):upper() .. ':')
            s = s .. icon .. num .. ' '
          end
          return vim.trim(s)
        end,
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    }

    vim.keymap.set('n', '<leader>bn', '<cmd>BufferLineCycleNext<CR>', { noremap = true, silent = true, desc = 'Next Buffer' })
    vim.keymap.set('n', '<leader>bp', '<cmd>BufferLineCyclePrev<CR>', { noremap = true, silent = true, desc = 'Previous Buffer' })
    vim.keymap.set('n', '<leader>bd', function()
      Snacks.bufdelete()
    end, { noremap = true, silent = true, desc = 'Delete Buffer' })
    vim.keymap.set('n', '<A-.>', '<cmd>BufferLineMoveNext<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<A-,>', '<cmd>BufferLineMovePrev<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', 'gb', '<cmd>BufferLinePick<CR>', { noremap = true, silent = true, desc = 'Pick buffer' })
  end,
}
