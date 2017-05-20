--------------------------------------------------------------------------------
-- [Initialising Stage]
--------------------------------------------------------------------------------
-- Construct a stage
local stage = Stage(	
							"Initialising Gamemode",
							5, 
							Color(255, 255, 255, 255),
							true,
							false
						)
								
-- Override the StageInit method
stage.StageInit = function()

	stage.SetStageVariable("loot_point_tier1", ents.FindByName("loot_point_tier1"))
	stage.SetStageVariable("loot_point_tier2", ents.FindByName("loot_point_tier2"))
	stage.SetStageVariable("loot_point_tier3", ents.FindByName("loot_point_tier3"))

	local endgamemovingbarriers = {}

	for i = 1, 8, 1 do

		endgamemovingbarriers[i] = ents.FindByName("endgame_moving_barrier" .. i)

	end

	stage.SetStageVariable("endgame_moving_barrier", endgamemovingbarriers)
	
end


-- Override the StageStart method
stage.StageStart = function()

	for k, v in pairs(ents.FindByClass("prop_physics")) do v:Remove() end

	local playerWithMostVictories = GetPlayerWithMostVictories()

	if(playerWithMostVictories ~= nil) then
		net.Start("ClientUpdateTCSGStatsForDisplay")
			net.WriteString(playerWithMostVictories[1]["LastKnownName"])
			net.WriteInt(playerWithMostVictories[1]["Victories"], 16)
		net.Broadcast()
	end

	local endgamemovingbarriers = stage.GetStageVariable("endgame_moving_barrier")

	if(endgamemovingbarriers) then
	
		for i = 1, 8, 1 do

			endgamemovingbarriers[i][1]:Fire("alpha", 0)
		
		end

	end

	----------------------------------------------------------------------------

	local lootpointstier1 = stage.GetStageVariable("loot_point_tier1")
	
	if(lootpointstier1) then
	
		for k, lootpointtier1 in pairs(lootpointstier1) do
			
			lootpointtier1.referencedCrateIndex = 
			SpawnEmptyCrate(lootpointtier1:EntIndex(),
			lootpointtier1:GetPos(), "tier1")
		
		end
		
	end

	----------------------------------------------------------------------------

	local lootpointstier2 = stage.GetStageVariable("loot_point_tier2")
	
	if(lootpointstier2) then
	
		for k, lootpointtier2 in pairs(lootpointstier2) do

			lootpointtier2.referencedCrateIndex = 
			SpawnEmptyCrate(lootpointtier2:EntIndex(),
			lootpointtier2:GetPos(), "tier2")
		
		end
		
	end

	----------------------------------------------------------------------------

	local lootpointstier3 = stage.GetStageVariable("loot_point_tier3")
	
	if(lootpointstier3) then
	
		for k, lootpointtier3 in pairs(lootpointstier3) do

			lootpointtier3.referencedCrateIndex = 
			SpawnEmptyCrate(lootpointtier3:EntIndex(),
			lootpointtier3:GetPos(), "tier3")
		
		end
		
	end

	----------------------------------------------------------------------------
	
end


-- Override the StageEnd method
stage.StageEnd = function()

	TransitionFadeAllPlayers()
	return false
	
end
--------------------------------------------------------------------------------
timedStagesSystem.AddStage(stage)
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [PropBreak Hook] -- for spawning items when breaking loot crates
--------------------------------------------------------------------------------
hook.Add("PropBreak", "TSSPropBreak", function(attacker, prop)
	
	-- If the broken prop has a lootPointIndex it means we can call a specific
	-- function for when its broken
	if(prop.lootPointIndex && prop.lootTier) then

		local cratelootpoint = ents.GetByIndex(prop.lootPointIndex)
		cratelootpoint.randomItemToDrop = 
		itemsRepository.GetRandomItemFromTier(prop.lootTier)

		cratelootpoint.droppedItemInWorldIndex = DropItemInWorld(
		cratelootpoint.randomItemToDrop, 
		ents.GetByIndex(cratelootpoint.referencedCrateIndex):GetPos()
		+ Vector(0, 0, 5))
	
	end
	
end)
--------------------------------------------------------------------------------