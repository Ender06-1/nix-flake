return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local servers = {
        "lua_ls",
        "clangd",
        "nil_ls",
        "ocamllsp",
      }

      for _, s in ipairs(servers) do
        -- vim.lsp.config(s, ...)
        vim.lsp.enable(s)
      end
    end,
  },
}
