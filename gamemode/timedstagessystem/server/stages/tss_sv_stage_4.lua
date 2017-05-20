--------------------------------------------------------------------------------
-- [Survival Games]
--------------------------------------------------------------------------------
-- Construct a stage
local stage = Stage(	
							"Survival Games", 
							300, 
							Color(135, 170, 30, 255),
							false,
							true
					)

-- Override the StageInit method								
stage.StageInit = function()

	local endgamemovingbarriers = {}

	for i = 1, 8, 1 do

		endgamemovingbarriers[i] = ents.FindByName("endgame_moving_barrier" .. i)

	end

	stage.SetStageVariable("endgame_moving_barrier", endgamemovingbarriers)
	
end


-- Override the StageStart method
stage.StageStart = function()

	local endgamemovingbarriers = stage.GetStageVariable("endgame_moving_barrier")
	
	timer.Create("TCSGEndGameBarrier", stage.GetStageLength() - (144 + 5), 1, function()
	
		if(endgamemovingbarriers) then

			net.Start("ClientEndGameBarrierNotify")
			net.Broadcast()
		
			for i = 1, 8, 1 do

				endgamemovingbarriers[i][1]:Fire("alpha", 255)
				endgamemovingbarriers[i][1]:Fire("setspeed", 96)
				endgamemovingbarriers[i][1]:Fire("open")
			
			end

		end

	end)
	
end						
--------------------------------------------------------------------------------
timedStagesSystem.AddStage(stage)
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [PostPlayerDeath Hook] -- 
--------------------------------------------------------------------------------
hook.Add("PostPlayerDeath", "TSSCheckForVictorDeath", function(ply)
	
	local players = player.GetAll()
	local alivePlayersCount = 0
	local alivePlayer = {}

	for k,v in pairs(players) do

		if(v:Alive() && v.isSpectating == false) then

			alivePlayersCount = alivePlayersCount + 1
			alivePlayer = v

		end

	end

	if(alivePlayersCount <= 1 && timedStagesSystem.GetCurStageIndex() 
	== 4) then

		alivePlayer:AddNamedData("victories", 1)
		alivePlayer:AddNamedData("tokens", 3)
		SavePlayerStatsToDatabase(alivePlayer)

		timer.Remove("TCSGEndGameBarrier")

		timer.Simple(3, function()
			timedStagesSystem.NextStage()
		end)

	end
	
end)
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [PlayerDisconnected Hook] -- for spawning items when breaking loot crates
--------------------------------------------------------------------------------
hook.Add("PlayerDisconnected", "TSSCheckForVictorDisconnect", function(ply)
	
	local players = player.GetAll()
	local alivePlayersCount = 0
	local alivePlayer = {}

	for k,v in pairs(players) do

		if(v:Alive() && v.isSpectating == false && v ~= ply) then

			alivePlayersCount = alivePlayersCount + 1
			alivePlayer = v

		end

	end

	if(alivePlayersCount <= 1 && timedStagesSystem.GetCurStageIndex()
	== 4) then

		alivePlayer:AddNamedData("victories", 1)
		alivePlayer:AddNamedData("tokens", 3)
		SavePlayerStatsToDatabase(alivePlayer)

		timer.Remove("TCSGEndGameBarrier")

		timer.Simple(3, function()
			timedStagesSystem.NextStage()
		end)

	end
	
end)
--------------------------------------------------------------------------------