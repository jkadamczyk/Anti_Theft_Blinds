PROJECT = anti_theft_blinds
PROJECT_DESCRIPTION = New project
PROJECT_VERSION = 0.1.0
DEPS= cowboy
DEP_PLUGINS = cowboy
ERLC_OPTS = +debug_info +warn_export_vars +warn_shadow_vars +warn_obsolete_guard

start: all
	./_rel/anti_theft_blinds_release/bin/anti_theft_blinds_release-1 console

include erlang.mk
