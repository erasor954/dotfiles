return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { 
		"nvim-lua/plenary.nvim" 
	},
	config = function()
		require("harpoon"):setup()
	end,
	keys = {
		{ "<leader>a", function() require("harpoon"):list():add() end, desc = "Harpoon Add File" },
		{ 
			"<C-e>", 
			function() 
				local harpoon = require("harpoon")
				harpoon.ui:toggle_quick_menu(harpoon:list()) 
			end, 
			desc = "Harpoon Menu" 
		},
		{ "<leader>1", function() require("harpoon"):list():select(1) end, desc = "Harpoon Buffer 1" },
		{ "<leader>2", function() require("harpoon"):list():select(2) end, desc = "Harpoon Buffer 2" },
		{ "<leader>3", function() require("harpoon"):list():select(3) end, desc = "Harpoon Buffer 3" },
		{ "<leader>4", function() require("harpoon"):list():select(4) end, desc = "Harpoon Buffer 4" },
		{ "<C-S-P>", function() require("harpoon"):list():prev() end, desc = "Harpoon Prev Buffer" },
		{ "<C-S-N>", function() require("harpoon"):list():next() end, desc = "Harpoon Next Buffer" },
	},
}
