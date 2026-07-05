return {
  'shellRaining/hlchunk.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    require('hlchunk').setup {
      chunk = {
        enable = true,
        duration = 100,
        delay = 50,
        style = {
          '#be68d8',
          '#c21f30',
        },
      },
    }
  end,
}
