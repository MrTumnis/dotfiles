return {
  'fynnfluegge/monet.nvim',
  name = 'monet',
  config = function()
    require('monet').setup {
      transparent_background = false,
      semantic_tokens = true,
      dark_mode = true,
      highlight_overrides = {},
      color_overrides = {},
      styles = {},
      vim.cmd.colorscheme 'monet',
    }
  end,
}
