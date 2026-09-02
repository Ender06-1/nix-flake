return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local languages = {
        "lua",
        "c",
        "nix",
        "ocaml",
      }

      require("nvim-treesitter").install(languages)

      for _, l in ipairs(languages) do
        vim.api.nvim_create_autocmd("FileType", {
          pattern = { l },
          callback = function()
            vim.treesitter.start()
          end,
        })
      end
    end,
  },
  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "1.*",
    opts = {
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      keymap = {
        preset = "enter",
        ["<C-j>"] = { "select_next" },
        ["<C-k>"] = { "select_prev" },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        c = { "clang-format" },
        ocaml = { "ocamlformat" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    },
  },
}
