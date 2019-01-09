{application, 'anti_theft_blinds', [
	{description, "New project"},
	{vsn, "0.1.0"},
	{modules, ['alarm_invoke_handler','anti_theft_blinds_app','anti_theft_blinds_sup','blind','close_all_handler','close_blind_handler','defuse_handler','http_listener','open_all_handler','open_blind_handler','start_handler','utils']},
	{registered, [anti_theft_blinds_sup]},
	{applications, [kernel,stdlib,cowboy,jiffy]},
	{mod, {anti_theft_blinds_app, []}},
	{env, []}
]}.