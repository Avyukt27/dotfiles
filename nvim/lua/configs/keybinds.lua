local opts = { expr = true, silent = true }

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('i', '<C-u>', '', opts)
vim.keymap.set('v', '<C-Right>', '"e"', opts)
vim.keymap.set('v', '<C-Left>', '"b"', opts)
vim.keymap.set('n', '<C-Right>', '"e"', opts)
vim.keymap.set('n', '<C-Left>', '"b"', opts)
vim.keymap.set('i', '<C-Right>', '"<C-o>w"', opts)
vim.keymap.set('i', '<C-Left>', '"<C-o>b"', opts)
vim.keymap.set('i', '<C-BS>', '"<C-o>db"', opts)
vim.keymap.set('i', '<C-Del>', '"<C-o>dw"', opts)

local latex_augroup = vim.api.nvim_create_augroup('LatexAutoSave', { clear = true })

vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
  pattern = { '*.tex' },
  group = latex_augroup,
  callback = function()
    if vim.bo.modified and vim.bo.filetype == 'tex' then
      vim.cmd 'silent! write'
    end
  end,
})

vim.b.latex_preview_job = vim.b.latex_preview_job or nil

vim.keymap.set('n', '<leader>lp', function()
  local current_file = vim.fn.expand '%:p'
  local project_dir = vim.fn.expand '%:p:h'
  local pdf_file = vim.fn.expand '%:p:r' .. '.pdf'

  if vim.bo.filetype ~= 'tex' then
    print 'Not a LaTeX file!'
    return
  end

  if not vim.b.latex_preview_job then
    vim.fn.jobstart({
      'latexmk',
      '-pvc',
      '-pdf',
      '-interaction=nonstopmode',
      vim.fn.expand '%:t',
    }, {
      cwd = project_dir,
      on_exit = function()
        vim.b.latex_preview_job = nil
      end,
    })
    print 'Started Live Preview'
  else
    print 'Live preview is already running'
  end

  vim.defer_fn(function()
    if vim.fn.filereadable(pdf_file) == 1 then
      vim.fn.jobstart({ 'zathura', pdf_file }, { detach = true })
    else
      print 'Waiting for PDF'
    end
  end, 1500)
end, { desc = 'Start Live LaTeX Preview', silent = true })

vim.keymap.set('n', 'gn', vim.lsp.buf.rename, { desc = 'Rename symbol' })

vim.keymap.set('n', '<leader>re', '<cmd>restart<cr>')

vim.keymap.set('n', '<leader>cc', function()
  local cc = require 'codecompanion'
  local chat = cc.last_chat()
  if chat and chat:is_visible() then
    chat:close()
  else
    cc.toggle()
  end
end, { desc = 'Toggle CodeCompanion AI Chat' })
vim.keymap.set('n', '<leader>ci', '<cmd>CodeCompanion<cr>', { desc = 'Prompt inline CodeCompanion AI' })

vim.keymap.set('n', '<leader>Mc', function()
  vim.ui.input({ prompt = 'Save session as: ' }, function(input)
    if not input or input == '' then
      return
    end
    MiniSessions.write(input)
  end)
end, { desc = 'Save session' })
vim.keymap.set('n', '<leader>Ms', '<cmd>lua MiniSessions.select()<cr>', { desc = 'Select session' })
vim.keymap.set('n', '<leader>Md', function()
  vim.ui.input({ prompt = 'Delete session: ' }, function(input)
    if not input or input == '' then
      return
    end
    MiniSessions.delete(input)
  end)
end, { desc = 'Delete session' })
