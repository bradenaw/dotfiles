return {
	"luukvbaal/statuscol.nvim",
	config = function()
		local builtin = require("statuscol.builtin")
		require("statuscol").setup({
			setopt = true,
			segments = {
				{ sign = { namespace = { "gitsigns" }, maxwidth = 1, colwidth = 1, auto = true } },
				{ sign = { namespace = { "diagnostic" }, maxwidth = 1, colwidth = 1, auto = true } },
				{ text = { builtin.lnumfunc } },
				{ text = { " " } },
			},
		})
	end,
}
