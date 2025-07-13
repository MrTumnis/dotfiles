return {
  'uloco/bluloco.nvim',
  require("bluloco").setup({
  style = "auto",               -- "auto" | "dark" | "light"
  transparent = true,
  italics = true,
  terminal = vim.fn.has("gui_running") == 0, -- bluoco colors are enabled in gui terminals per default.
  guicursor = true,
  rainbow_headings = false,     -- if you want different colored headings for each heading level
})

