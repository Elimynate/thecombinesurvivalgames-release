--------------------------------------------------------------------------------
-- [Add CS Lua Files]
--------------------------------------------------------------------------------
-- [Client]
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("core/client/cl_hud.lua")
AddCSLuaFile("core/client/cl_fonts.lua")
AddCSLuaFile("core/client/cl_scoreboard.lua")
AddCSLuaFile("core/client/cl_qmenu.lua")
AddCSLuaFile("core/client/qmenu/cl_qmenu_admin.lua")
AddCSLuaFile("core/client/cl_screencasts.lua")
AddCSLuaFile("core/client/cl_3d2d.lua")
AddCSLuaFile("core/client/cl_polybarclass.lua")
AddCSLuaFile("core/client/cl_notifications.lua")

AddCSLuaFile("timedstagessystem/tss_cl_init.lua")
AddCSLuaFile("inventorysystem/is_cl_init.lua")
AddCSLuaFile("daynightsystem/cl_load.lua")




-- [Shared]
AddCSLuaFile("shared.lua")
AddCSLuaFile("core/shared/sh_constants.lua")
AddCSLuaFile("core/shared/sh_teams.lua")
AddCSLuaFile("core/shared/sh_logger.lua")
AddCSLuaFile("core/shared/sh_config.lua")

AddCSLuaFile("inventorysystem/is_shared.lua")
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [Includes]
--------------------------------------------------------------------------------
-- [Shared]
include("shared.lua" )
include("core/shared/sh_constants.lua")
include("core/shared/sh_teams.lua")
include("core/shared/sh_logger.lua")
include("core/shared/sh_config.lua")

include("inventorysystem/is_shared.lua")



-- [Server]
include("resources.lua")
include("core/server/sv_helperfunctions.lua")
include("core/server/sv_concommands.lua")
include("core/server/sv_database.lua")
include("core/server/sv_player.lua")

include("timedstagessystem/tss_init.lua")
include("inventorysystem/is_init.lua")
include("daynightsystem/load.lua")
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [Initialize Function]
--------------------------------------------------------------------------------
function GM:Initialize()

	logger.Info(GAMEMODE_CORE_PREFIX .. "Gamemode Initialized")
	
	-- Add networked strings for communication between client and server
	util.AddNetworkString("ClientUpdateStageInformation")
	
	util.AddNetworkString("ClientReceiveInventoryUpdate")
	util.AddNetworkString("ClientRequestInventoryUpdate")
	
	util.AddNetworkString("ClientRequestDropItem")
	util.AddNetworkString("ClientRequestUseItem")

	util.AddNetworkString("ClientUpdateTCSGStatsForDisplay")

	util.AddNetworkString("ClientInitialSpawnMenuPopup")

	util.AddNetworkString("ClientEndGameBarrierNotify")
	
end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [PlayerSetHandsModel Function]
--------------------------------------------------------------------------------
function GM:PlayerSetHandsModel(ply, ent)

	-- Show hands on player screen (as by default they don't show)
	local simplemodel = player_manager.TranslateToPlayerModelName(
	ply:GetModel())
	local info = player_manager.TranslatePlayerHands(simplemodel)
	if (info) then
	
		ent:SetModel(info.model)
		ent:SetSkin(info.skin)
		ent:SetBodyGroups(info.body)
		
	end

end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [PlayerConnect Function]
--------------------------------------------------------------------------------
function GM:PlayerConnect(name, ip)
	logger.Info(GAMEMODE_CORE_PREFIX .. name .. 
	" has connected to the server.")
end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [PlayerDisconnected Function]
--------------------------------------------------------------------------------
function GM:PlayerDisconnected(ply)
	logger.Info(GAMEMODE_CORE_PREFIX .. ply:GetName() .. 
	" has disconnected.")
	if(!ply) then return end
	SavePlayerStatsToDatabase(ply)
end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [PlayerInitialSpawn Function]
--------------------------------------------------------------------------------
function GM:PlayerInitialSpawn(ply)

	ply:SetupFirstTimeJoin()
	ply:SetupInventory(ISConfig.PlayerInventorySize)

	if(timedStagesSystem.GetCurStage().GetPlayersCanSpawn()) then

		logger.Info(GAMEMODE_CORE_PREFIX .. ply:GetName() .. " has spawned in.")

	else
		
		ply:KillSilent()
		ply:GoIntoSpectateMode()

	end

	net.Start("ClientInitialSpawnMenuPopup")
	net.Send(ply)
	
end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [PlayerSpawn Function]
--------------------------------------------------------------------------------
function GM:PlayerSpawn(ply)

	local playerWithMostVictories = GetPlayerWithMostVictories()

	if(playerWithMostVictories ~= nil) then
		net.Start("ClientUpdateTCSGStatsForDisplay")
			net.WriteString(playerWithMostVictories[1]["LastKnownName"])
			net.WriteInt(playerWithMostVictories[1]["Victories"], 16)
		net.Broadcast()
	end

	if(!timedStagesSystem.GetCurStage().GetPlayersCanSpawn()) then

		ply:KillSilent()
		ply:GoIntoSpectateMode()

	else

		ply:UnSpectate()
		ply:SetPlayerModel()
		ply:LoadOut()

		ply:SetRenderMode(RENDERMODE_TRANSALPHA)
		ply:SetColor(Color(255, 255, 255, 150))
		ply:SetCollisionGroup(COLLISION_GROUP_PLAYER)

	end

end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [PlayerSwitchFlashlight Function]
--------------------------------------------------------------------------------
function GM:PlayerSwitchFlashlight(ply, enabled)

    return ply:Alive()
	 
end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [PlayerNoClip Function]
--------------------------------------------------------------------------------
function GM:PlayerNoClip( ply )

	return ply:IsAdmin()
	
end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [GetFallDamage Function]
--------------------------------------------------------------------------------
function GM:GetFallDamage(ply, speed)

	return (speed/14)
	
end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [PlayerAuthed Function]
--------------------------------------------------------------------------------
function GM:PlayerAuthed(ply)

	logger.Info(GAMEMODE_CORE_PREFIX .. ply:GetName() .. 
		" has been authenticated.")
		
end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [PlayerDeath Function] -- set spectate mode at right times
--------------------------------------------------------------------------------
hook.Add("PlayerDeath", "SetSpectateMode", function(victim, inflictor, attacker)

	-- Drop all of a players items when they die
	victim:DropAllFromInventory()

	victim:AddNamedData("deaths", 1)
	SavePlayerStatsToDatabase(victim)

	if(attacker ~= nil && victim ~= attacker && attacker:IsPlayer()) then 

		attacker:AddNamedData("kills", 1)
		attacker:AddNamedData("tokens", 1)
		SavePlayerStatsToDatabase(attacker)

	end
	

	if(timedStagesSystem.GetCurStage().GetPlayersCanSpawn()) then

		timer.Simple(1.5, function()

			victim:Spawn()

		end)

	else

		timer.Simple(1.5, function()

			victim:GoIntoSpectateMode()

		end)
		

	end

end)
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [PlayerSilentDeath Function] -- set spectate mode at right times
--------------------------------------------------------------------------------
function GM:PlayerSilentDeath(ply)


	if(timedStagesSystem.GetCurStage().GetPlayersCanSpawn()) then

		timer.Simple(0.1, function()

			ply:Spawn()

		end)

	else
		
		timer.Simple(0.1, function()

			ply:GoIntoSpectateMode()

		end)

	end

end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [PlayerDeathThink Function]
--------------------------------------------------------------------------------
function GM:PlayerDeathThink(ply)

	if(ply.isSpectating) then
		ply:SpectateMode()
	end

	return false

end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [CanPlayerSuicide Function]
--------------------------------------------------------------------------------
function GM:CanPlayerSuicide(ply)

	return (timedStagesSystem.GetCurStage().GetPlayersTakeDamage())

end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [EntityTakeDamage Function]
--------------------------------------------------------------------------------
function GM:EntityTakeDamage(target, dmg)

	if(target:IsPlayer() && 
	!timedStagesSystem.GetCurStage().GetPlayersTakeDamage()) then

		dmg:SetDamage(0)

		local players = player.GetAll()
		local alivePlayersCount = 0

		for k,v in pairs(players) do

			if(v:Alive()) then

				alivePlayersCount = alivePlayersCount + 1

			end

		end

		if(alivePlayersCount <= 1) then

			for k,v in pairs(players) do

				if(v && v:Alive()) then

					v:GodEnable()
					dmg:SetDamage(0)

				end

			end

		end

	end

end
--------------------------------------------------------------------------------