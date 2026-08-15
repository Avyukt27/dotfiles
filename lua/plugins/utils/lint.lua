return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPost', 'BufNewFile', 'BufWritePost' },
  config = function()
    local lint = require 'lint'

    lint.linters_by_ft = {
      python = { 'ruff' },
      javascript = { 'eslint' },
      typescript = { 'eslint' },
      javascriptreact = { 'eslint' },
      typescriptreact = { 'eslint' },
      vue = { 'eslint' },
    }

    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        local current_file = vim.api.nvim_buf_get_name(0)
        if current_file == '' then
          return
        end
        local filetype = vim.bo.filetype
        local linters = lint.linters_by_ft[filetype] or {}
        for _, linter in ipairs(linters) do
          if linter == 'eslint' then
            local has_eslint_config = vim.fs.root(current_file, {
              'eslint.config.js',
              'eslint.config.mjs',
              'eslint.config.cjs',
              '.eslintrc.js',
              '.eslintrc.json',
              'package.json',
            })
            if not has_eslint_config then
              return
            end
          end
        end
        lint.try_lint()
      end,
    })
  end,
}
