--------------------------------------------------------------------------------
-- [Constants relating to print outs]
--------------------------------------------------------------------------------
GAMEMODE_PREFIX = "[TCSG]\t"



CORE_PREFIX = "[CORE]\t"
GAMEMODE_CORE_PREFIX = GAMEMODE_PREFIX .. CORE_PREFIX



STAGES_PREFIX = "[STGE]\t"
GAMEMODE_STAGES_PREFIX = GAMEMODE_PREFIX .. STAGES_PREFIX



ADMIN_PREFIX = "[ADMN]\t"
GAMEMODE_ADMIN_PREFIX = GAMEMODE_PREFIX .. ADMIN_PREFIX



LUA_PREFIX = "[LUA ]\t"
LUA_COLLECTGARBAGE_COUNT = 	LUA_PREFIX ..
							string.format("%.2f",
							(collectgarbage("count") / 1024)) ..
							" megabytes in use."
--------------------------------------------------------------------------------