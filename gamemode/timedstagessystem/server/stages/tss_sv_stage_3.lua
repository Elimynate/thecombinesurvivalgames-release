--------------------------------------------------------------------------------
-- [Survival Games Initialisation]
--------------------------------------------------------------------------------
-- Construct a stage
local stage = Stage(	
							"Survival Games Initialisation", 
							20, 
							Color(145, 215, 165, 255),
							false,
							false
						)

-- Override the StageInit method									
stage.StageInit = function()

	stage.SetStageVariable("teleport_arena_pod", ents.FindByName("teleport_arena_pod")) 
	
	
	stage.SetStageVariable("hatch", ents.FindByName("hatch"))
	
	
	stage.SetStageVariable("arena_pod_barrier", ents.FindByName("arena_pod_barrier")) 
	
	
end


-- Override the StageStart method	
stage.StageStart = function()
	
	local arenapodtelepoints = stage.GetStageVariable("teleport_arena_pod")
	local arenapodtelepointSelectionBucket = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12,
											13, 14, 15, 16, 17, 18, 19, 20, 21, 22,
											23, 24}
	
	ShuffleTable(arenapodtelepointSelectionBucket)

	if(arenapodtelepoints) then
		
		local i = 1
		for k, ply in pairs(player.GetAll()) do
			

			ply:SetPos(arenapodtelepoints[arenapodtelepointSelectionBucket[i]]:GetPos())
			--arenapodtelepoints[podToPlacePlyIn]:SetKeyValue("target", ply:SteamID())
			--arenapodtelepoints[podToPlacePlyIn]:Fire("Teleport")

			i = i + 1
			
		end
	
	end

	timer.Simple(2, function()
	
		local hatches = stage.GetStageVariable("hatch")
	
		if(hatches) then
		
			for k, hatch in pairs(hatches) do
				hatch:Fire("Open")
			end
		
		end
		
	end)

	timer.Simple((stage.GetStageLength() - 3), function()
		for k,v in pairs(player.GetAll()) do

			v:EmitSound("hl1/fvox/beep.wav", 100, 100)

		end
	end)

	timer.Simple((stage.GetStageLength() - 2), function()
		for k,v in pairs(player.GetAll()) do

			v:EmitSound("hl1/fvox/beep.wav", 100, 100)

		end
	end)
	--npc/overwatch/radiovoice/two.wav"

	timer.Simple((stage.GetStageLength() - 1), function()
		for k,v in pairs(player.GetAll()) do

			v:EmitSound("hl1/fvox/beep.wav", 100, 100)

		end
	end)
	
end


-- Override the StageEnd method	
stage.StageEnd = function()
	
	local podbarriers = stage.GetStageVariable("arena_pod_barrier")
	
	if(podbarriers) then
	
		for k, podbarrier in pairs(podbarriers) do
			podbarrier:Fire("Disable")
			podbarrier:EmitSound("ambient/alarms/warningbell1.wav", 100, 100)
		end
	
	end

	return false
	
end
--------------------------------------------------------------------------------
timedStagesSystem.AddStage(stage)
--------------------------------------------------------------------------------