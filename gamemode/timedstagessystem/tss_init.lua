--------------------------------------------------------------------------------
-- [Add CS Lua Files]
--------------------------------------------------------------------------------
-- [Client]
AddCSLuaFile("client/tss_cl_displaystages.lua")
AddCSLuaFile("client/tss_cl_admin.lua")
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [Includes]
--------------------------------------------------------------------------------
-- [Server]
include("server/classes/tss_sv_stage.lua" )
include("server/classes/tss_sv_timedstagessystem.lua" )
include("server/tss_sv_concommands.lua" )

include("server/stages/tss_sv_stage_1.lua" )
include("server/stages/tss_sv_stage_2.lua" )
include("server/stages/tss_sv_stage_3.lua" )
include("server/stages/tss_sv_stage_4.lua" )
include("server/stages/tss_sv_stage_5.lua" )
include("server/stages/tss_sv_stage_6.lua" )
--------------------------------------------------------------------------------