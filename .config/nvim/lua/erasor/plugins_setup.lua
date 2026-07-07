-- Helper for stripping away the github part
_G.gh = function(repo)
	return "https://github.com/" .. repo
end

_G.cb = function(repo)
	return "https://codeberg.org/" .. repo
end

-- Theme
require("erasor.plugins.colors")

-- Core
require("erasor.plugins.treesitter")
require("erasor.plugins.fzf")
require("erasor.plugins.harpoon")

-- UI
require("erasor.plugins.lualine")

-- LSP
require("erasor.plugins.conform")
require("erasor.plugins.lsp")

require("erasor.plugins.auto_pairs")
