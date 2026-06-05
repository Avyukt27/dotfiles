return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>bf',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = 'Format Buffer',
    },
  },
  opts = {
    formatters_by_ft = {
      bash = { 'shfmt' },
      c = { 'clang-format' },
      cpp = { 'clang-format' },
      css = { 'prettierd' },
      fortran = { 'fprettify' },
      html = { 'prettierd' },
      java = { 'google-java-format' },
      javascript = { 'prettierd' },
      javascriptreact = { 'prettierd' },
      lua = { 'stylua' },
      python = { 'ruff_format' },
      sh = { 'shfmt' },
      typescript = { 'prettierd' },
      typescriptreact = { 'prettierd' },
      vue = { 'prettierd' },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = 'fallback',
    },
  },
}
