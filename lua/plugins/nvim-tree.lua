local M = {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	dependencies = {"nvim-tree/nvim-web-devicons"},
    	config = function()
        	require("nvim-tree").setup {}
    	end
}

return M
