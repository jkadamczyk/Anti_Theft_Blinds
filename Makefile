PROJECT = anti_theft_blinds
PROJECT_DESCRIPTION = New project
PROJECT_VERSION = 0.1.0
DEPS= cowboy

start: all
	./_rel/anti_theft_blinds_release/bin/anti_theft_blinds_release-1 console

include erlang.mk
