local wezterm = require("wezterm")
local nf = wezterm.nerdfonts

return {
	-- Process Icons
	["docker"] = nf.linux_docker,
	["docker-compose"] = nf.linux_docker,
	["psql"] = nf.dev_postgresql,
	["k8s"] = nf.linux_kubernetes,
	["kubectl"] = nf.linux_kubernetes,
	["nvim"] = nf.custom_neovim,
	["vim"] = nf.dev_vim,
	["go"] = nf.go_golang,
	["zsh"] = nf.dev_terminal,
	["bash"] = nf.cod_terminal_bash,
	["btm"] = nf.md_chart_areaspline,
	["htop"] = nf.md_chart_areaspline,
	["cargo"] = nf.dev_rust,
	["node"] = nf.dev_nodejs_small,
	["git"] = nf.dev_git,
	["lua"] = nf.cod_file_type_lua,
	["wget"] = nf.md_arrow_down_box,
	["curl"] = nf.md_web,
	["gh"] = nf.dev_github_badge,
	["python"] = nf.dev_python,
	["ruby"] = nf.dev_ruby,
	["ssh"] = nf.md_ssh,

	-- Default fallback
	["default"] = nf.md_application,
}
