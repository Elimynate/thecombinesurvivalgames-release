--------------------------------------------------------------------------------
-- [Victors Recognition]
--------------------------------------------------------------------------------
-- Construct a stage
local stage = Stage(	
							"Victors Ceremony", 
							10, 
							Color(245, 205, 65, 255),
							false,
							false
						)

-- Override the StageInit method								
stage.StageInit = function()

	stage.SetStageVariable("teleport_victor", ents.FindByName("teleport_victor"))
	
end

-- Override the StageStart method
stage.StageStart = function()

	local teleportvictor = stage.GetStageVariable("teleport_victor")
	
	if(teleportvictor) then
		
		for k, ply in pairs(player.GetAll()) do
		
			if(ply:Alive()) then

				teleportvictor[1]:SetKeyValue("target", ply:SteamID())
				teleportvictor[1]:Fire("Teleport")
				
				break
			
			end
		
		end
		
	end
	
end
--------------------------------------------------------------------------------
timedStagesSystem.AddStage(stage)
--------------------------------------------------------------------------------