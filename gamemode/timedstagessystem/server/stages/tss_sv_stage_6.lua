--------------------------------------------------------------------------------
-- [Reset Stage]
--------------------------------------------------------------------------------
-- Construct a stage
local stage = Stage(	
							"Resetting", 
							5, 
							Color(255, 255, 255, 255),
							false,
							false
						)
				
-- Override the StageInit method				
stage.StageInit = function()

	stage.SetStageVariable("loot_point_tier1", ents.FindByName("loot_point_tier1"))
	stage.SetStageVariable("loot_point_tier2", ents.FindByName("loot_point_tier2"))
	stage.SetStageVariable("loot_point_tier3", ents.FindByName("loot_point_tier3"))

	stage.SetStageVariable("hatch", ents.FindByName("hatch"))
	stage.SetStageVariable("arena_pod_barrier", ents.FindByName("arena_pod_barrier"))

	local endgamemovingbarriers = {}

	for i = 1, 8, 1 do

		endgamemovingbarriers[i] = ents.FindByName("endgame_moving_barrier" .. i)

	end

	stage.SetStageVariable("endgame_moving_barrier", endgamemovingbarriers)

	
end


-- Override the StageStart method	
stage.StageStart = function()

	SilentKillAllLivePlayers()

	for kPly, ply in pairs(player.GetAll()) do
		ply:SetupInventory(ISConfig.PlayerInventorySize)
	end


	local endgamemovingbarriers = stage.GetStageVariable("endgame_moving_barrier")

	if(endgamemovingbarriers) then
	
		for i = 1, 8, 1 do
			
			endgamemovingbarriers[i][1]:Fire("setspeed", 10000)
			endgamemovingbarriers[i][1]:Fire("close")
		
		end

	end

	timer.Remove("TCSGEndGameBarrier")
	
	
	
	local hatches = stage.GetStageVariable("hatch")
	
	if(hatches) then
	
		for k, hatch in pairs(hatches) do
			hatch:Fire("Close")
		end
	
	end
	
	
	local podbarriers = stage.GetStageVariable("arena_pod_barrier")
	
	if(podbarriers) then
	
		for k, podbarrier in pairs(podbarriers) do
			podbarrier:Fire("Enable")
		end
	
	end
	
	
	for k, v in pairs(ents.FindByClass("prop_physics")) do v:Remove() end

	
end
--------------------------------------------------------------------------------
timedStagesSystem.AddStage(stage)
--------------------------------------------------------------------------------