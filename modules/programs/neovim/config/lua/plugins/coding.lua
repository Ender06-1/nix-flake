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
        "java",
        "javadoc",
        "html",
        "css",
        "printf",
        "comment",
        "javascript",
        "typescript",
        "tsx",
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
        nix = { "treefmt", lsp_format = "fallback" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },
}
