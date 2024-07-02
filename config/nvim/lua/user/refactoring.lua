require("refactoring").setup({
	prompt_func_return_type = {
		go = true,
	},
	prompt_func_param_type = {
		go = true,
	},
	printf_statements = {},
	print_var_statements = {},
	show_success_message = true, -- shows a message with information about the refactor on success
	-- i.e. [Refactor] Inlined 3 variable occurrences
})
