local M = {}

function M.setup()
  -- filetype detection
  vim.filetype.add {
    extension = { crbasic = 'crbasic', cr300 = 'crbasic', cr8 = 'crbasic' },
    pattern = {
      ['.*%.CRBASIC'] = 'crbasic',
      ['.*%.CR300'] = 'crbasic',
      ['.*%.CR8'] = 'crbasic',
      ['*.CR1'] = 'crbasic',
      ['*.cr1'] = 'crbasic',
      ['*cr1X'] = 'crbasic',
      ['*.CR1X'] = 'crbasic',
      ['*.CR6'] = 'crbasic',
      ['*.cr6'] = 'crbasic',
    },
  }

  -- syntax on FileType=crbasic
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'crbasic',
    callback = function()
      if vim.b.current_syntax then
        return
      end
      vim.cmd [[
        syntax match crbasicComment "'.*$"
        highlight default link crbasicComment Comment

        syntax region crbasicString start=+"+ skip=+\\.+ end=+"+
        highlight default link crbasicString String

        syntax match crbasicNumber "\<\d\+\(\.\d\+\)\?\([eE][+-]\=\d\+\)\?\>"
        highlight default link crbasicNumber Number

        syntax keyword crbasicKeyword If Then Else End EndIf For Next While Wend Call Return
        highlight default link crbasicKeyword Keyword

        syntax keyword crbasicFunction Public Const Alias Units DataTable Sample Interval
        highlight default link crbasicFunction Function

        syntax keyword crbasicType Float Integer Boolean String
        highlight default link crbasicType Type
      ]]
      vim.b.current_syntax = 'crbasic'
    end,
  })
end

return M
