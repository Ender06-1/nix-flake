require("config.keymaps")
require("config.options")
require("config.lazy")

vim.cmd("colorscheme onedark")

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})
