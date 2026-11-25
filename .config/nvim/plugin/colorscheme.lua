vim.pack.add({
  { src = "https://github.com/EdenEast/nightfox.nvim" },
})

local colorscheme = require("nightfox")

colorscheme.setup({
  colorblind = {
    enable = true,
  },
})

-- carbonfox
-- dawnfox
-- dayfox
-- duskfox
-- nightfox
-- nordfox
-- terafox

vim.cmd("colorscheme dayfox")
