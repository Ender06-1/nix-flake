local map = vim.keymap.set

map("i", "jk", "<ESC>")

map({ "n", "v" }, "j", "gj")
map({ "n", "v" }, "k", "gk")
