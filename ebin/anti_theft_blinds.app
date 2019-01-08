{application, 'anti_theft_blinds', [
	{description, "New project"},
	{vsn, "0.1.0"},
	{modules, ['anti_theft_blinds_app','anti_theft_blinds_root','anti_theft_blinds_sup']},
	{registered, [anti_theft_blinds_sup]},
	{applications, [kernel,stdlib,cowboy]},
	{mod, {anti_theft_blinds_app, []}},
	{env, []}
]}.