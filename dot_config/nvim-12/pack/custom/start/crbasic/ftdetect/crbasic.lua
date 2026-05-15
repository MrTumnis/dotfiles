-- Option A: filetype.add (fast path)
vim.filetype.add {
  extension = { crbasic = 'crbasic', cr300 = 'crbasic', CR3 = 'crbasic', cr8 = 'crbasic', CR1X = 'crbasic'},
  pattern = {
    ['.*%.CRBASIC'] = 'crbasic',
    ['.*%.CR300'] = 'crbasic',
    ['.*%.CR3'] = 'crbasic',
    ['.*%.CR8'] = 'crbasic',
    ['*.CR1'] = 'crbasic',
    ['*.cr1'] = 'crbasic',
    ['*cr1X'] = 'crbasic',
    ['*cr1x'] = 'crbasic',
    ['*.CR1X'] = 'crbasic',
    ['*.CR6'] = 'crbasic',
    ['*.cr6'] = 'crbasic',
  },
}

-- Option B: autocmd fallback (keep as-is or remove; both are fine)
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '*.crbasic', '*.CRBASIC', '*.cr300','*.CR300','*.CR3', '*.CR8', '*.cr8', '*.CR1', '*.cr1', '*cr1X', '*cr1x', '*.CR1X', '*.CR6', '*.cr6' },
  callback = function()
    vim.bo.filetype = 'crbasic'
  end,
})
