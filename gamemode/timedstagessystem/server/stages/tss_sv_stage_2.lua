--------------------------------------------------------------------------------
-- [Waiting Stage]
--------------------------------------------------------------------------------
-- Construct a stage
local stage = Stage(	
							"Waiting For Players", 
							45, 
							Color(65, 135, 245, 255),
							true,
							false
						)

-- Override the StageInit method								
stage.StageInit = function()

	stage.SetStageVariable("teleport_waiting_area", ents.FindByName("teleport_waiting_area"))
	
end


-- Override the StageStart method
stage.StageStart = function()
	
	SpawnAllDeadPlayers()

	AlphaColourAndNoCollideAllPlayers()

	local waitingareateleports = stage.GetStageVariable("teleport_waiting_area")
	
	if(waitingareateleports) then
		
		local i = 1
		
		for k, ply in pairs(player.GetAll()) do
		
			waitingareateleports[i]:SetKeyValue("target", ply:SteamID())
			waitingareateleports[i]:Fire("Teleport")
			
			i = i + 1
			
			if(i > TCSG.MaxPlayers) then break end
		
		end
		
	end
	
end


-- Override the StageEnd method
stage.StageEnd = function()

	if(#player.GetAll() <= 1) then
		
		return true

	else

		NormalColourAndDefaultCollideAllPlayers()
		TransitionFadeAllPlayers()
		return false

	end
	
end
--------------------------------------------------------------------------------
timedStagesSystem.AddStage(stage)
--------------------------------------------------------------------------------