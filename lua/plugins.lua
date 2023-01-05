local packer = require("packer")
packer.startup(
  function(use)
    -- Packer 可以管理自己本身
    use 'wbthomason/packer.nvim'
    -- plugins list
    --------------------- colorschemes --------------------
    use("folke/tokyonight.nvim")
    use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons"})
    use({'akinsho/bufferline.nvim', tag = "v3.*", requires = {"nvim-tree/nvim-web-devicons", "moll/vim-bbye" }})

end)

