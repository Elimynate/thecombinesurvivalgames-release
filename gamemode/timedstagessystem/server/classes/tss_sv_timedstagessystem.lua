--------------------------------------------------------------------------------
-- [TimedStagesSystem Object]
--------------------------------------------------------------------------------
function TimedStagesSystem()

	local self = {}
	
	-- [Private Class Variables] -----------------------------------------------
	local stages = {}
	local startTime = 0
	local curStage = 1
	----------------------------------------------------------------------------
	

	-- [AddStage Method] -------------------------------------------------------
	function self.AddStage(stage)
		stages[#stages+1] = stage
	end
	----------------------------------------------------------------------------

	
	-- [Getters] ---------------------------------------------------------------
	function self.GetStages() 
		return stages 
	end
	
	function self.GetStartTime() 
		return startTime 
	end
	
	function self.GetCurStageIndex() 
		return curStage 
	end

	function self.GetCurStage() 
		return stages[curStage] 
	end

	function self.GetStageVariables(stageIndex) 
		return stages[stageIndex].GetStageVariables() 
	end

	function self.GetStageVariable(stageIndex, arg) 
		return stages[stageIndex].GetStageVariable(arg) 
	end
	----------------------------------------------------------------------------
	
	
	-- [Start Method] ----------------------------------------------------------
	function self.Start()
	
		if(#stages <= 0) then return end

		curStage = 1

		START_TIMED_STAGES = true
		STOP_TIMED_STAGES = false
		
		for k, v in pairs(stages) do
			v.StageInit()
		end
		
		startTime = CurTime()
		
		stages[curStage].StageStart()
		
		logger.Info(GAMEMODE_STAGES_PREFIX .. 
		"Timed Stages started. Starting with stage \"" .. 
		stages[curStage].GetStageName() ..
		"\" which will last for " .. stages[curStage].GetStageLength() .. 
		" seconds.")
		
		if(!timer.Exists("timedStagesTimer")) then

			timer.Create(	"timedStagesTimer", 
							stages[curStage].GetStageLength(), 
							0, 
							function()
								self.NextStage()
							end)
			
		end

		self.NetSendStageInformationToAllClients()
		
		self.Loop()
		
	end
	----------------------------------------------------------------------------
	
	
	-- [NextStage Method] ------------------------------------------------------
	function self.NextStage()
	
		logger.Info(LUA_COLLECTGARBAGE_COUNT)
	
		if(!STOP_TIMED_STAGES) then
		
			local stayOnCurrentStage = stages[curStage].StageEnd()
		
			if(stayOnCurrentStage) then

				curStage = curStage

			else

				if(curStage + 1 > #stages) then
					curStage = 1
				else
					curStage = curStage + 1
				end

			end

			
		
			logger.Info(GAMEMODE_STAGES_PREFIX .. 
			"Now starting stage \"" .. stages[curStage].GetStageName() ..
			"\" which will last for " .. stages[curStage].GetStageLength() .. 
			" seconds.")
			
			startTime = CurTime()
			
			
			
			stages[curStage].StageStart()

			self.NetSendStageInformationToAllClients()
			
			self.Loop()
			
		end
		
	end
	----------------------------------------------------------------------------
	
	
	-- [NetSendStageInformationToAllClients Method] ----------------------------
	function self.NetSendStageInformationToAllClients()
	
		net.Start("ClientUpdateStageInformation")
		net.WriteString(stages[curStage].GetStageName())
		net.WriteInt(stages[curStage].GetStageLength(), 16)
		net.WriteFloat(startTime)
		net.WriteColor(stages[curStage].GetStageColour())
		net.Broadcast()
	
	end
	----------------------------------------------------------------------------
	
	
	-- [Loop Method] -----------------------------------------------------------
	function self.Loop()
	
		if(!STOP_TIMED_STAGES) then
				
			if(timer.Exists("timedStagesTimer")) then
				timer.Adjust(	"timedStagesTimer", 
								stages[curStage].GetStageLength(), 
								0, 
								function()
									self.NextStage()
								end)
			end

		end
		
	end
	----------------------------------------------------------------------------
	
	
	-- [Stop Method] -----------------------------------------------------------
	function self.Stop()

		logger.Info(GAMEMODE_STAGES_PREFIX .. 
		"Timed Stages stopped")
		START_TIMED_STAGES = false
		STOP_TIMED_STAGES = true
		timer.Remove("timedStagesTimer")
		
	end
	----------------------------------------------------------------------------
	
	
	return self

end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [Declare Variables]
--------------------------------------------------------------------------------
START_TIMED_STAGES = false
STOP_TIMED_STAGES = false
timedStagesSystem = TimedStagesSystem()
--------------------------------------------------------------------------------
-- When the first player first spawns start the stages. If they have been
-- previously stopped then restart them
hook.Add("PlayerInitialSpawn", "Call Timed Stages", function()

	if(!START_TIMED_STAGES) then
		timedStagesSystem.Start()
	end
	
	-- When a player first joins the server send them the
	-- current stage information
	timedStagesSystem.NetSendStageInformationToAllClients()
	
end)

-- If the server is empty stop the stages
hook.Add("PlayerDisconnected", "Check If Server Empty", function()
	
	if(!STOP_TIMED_STAGES) then
		if((#player.GetAll() - 1) <= 0) then
			timedStagesSystem.Stop()
		end
	end
	
end)
--------------------------------------------------------------------------------