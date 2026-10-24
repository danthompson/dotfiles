vim.pack.add({
  { src = "https://github.com/EdenEast/nightfox.nvim" },
})

local colorschem = require("nightfox")

colorschem.setup({
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

vim.cmd("colorscheme carbonfox")
