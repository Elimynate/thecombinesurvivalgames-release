--------------------------------------------------------------------------------
-- [Stage Object]
--------------------------------------------------------------------------------
function Stage(	
						stageName,
						stageLength, 
						stageColour, 
						playersCanSpawn,
						playersTakeDamage,
						stageVariables
					)

	local self = {}
	
	-- [Private Class Variables] -----------------------------------------------
	local stageName = stageName or "Unnamed Stage"
	local stageLength = stageLength or 60
	local stageColour = stageColour or Color(255, 255, 255, 255)
	local playersCanSpawn = playersCanSpawn
	local playersTakeDamage = playersTakeDamage
	local stageVariables = stageVariables or {}
	----------------------------------------------------------------------------
	
	
	-- [Getters] ---------------------------------------------------------------
	function self.GetStageName()
		return stageName 
	end
	
	function self.GetStageLength() 
		return stageLength 
	end
	
	function self.GetStageColour() 
		return stageColour 
	end
	
	function self.GetPlayersCanSpawn() 
		return playersCanSpawn 
	end

	function self.GetPlayersTakeDamage() 
		return playersTakeDamage 
	end

	function self.GetStageVariable(arg) 
		return stageVariables[arg]
	end
	
	function self.GetStageVariables() 
		return stageVariables 
	end
	----------------------------------------------------------------------------


	-- [Setters] ---------------------------------------------------------------
	function self.SetStageName(arg)
		stageName = arg
	end
	
	function self.SetStageLength(arg) 
		stageLength = arg
	end
	
	function self.SetStageColour(arg) 
		stageColour = arg
	end
	
	function self.SetPlayersCanSpawn(arg) 
		playersCanSpawn = arg
	end

	function self.SetPlayersTakeDamage(arg) 
		playersTakeDamage = arg
	end

	function self.SetStageVariable(arg, arg2) 
		stageVariables[arg] = arg2
	end
	
	function self.SetStageVariables(arg) 
		stageVariables = arg
	end
	----------------------------------------------------------------------------
	
	
	-- [StageInit Method] -----------------------------------------------------
	function self.StageInit()
	
		-- Override this in your object if you want a stage to have a specific
		-- initilisation (this is only called once at the beginning of
		-- the timedStages start)
		
		logger.Warning(GAMEMODE_STAGES_PREFIX .. 
		"\"" .. stageName .. "\" Init method not overwritten.")
	
	end
	----------------------------------------------------------------------------
	
	
	-- [StageStart Method] -----------------------------------------------------
	function self.StageStart()
	
		-- Override this in your object if you want specific things to 
		-- happen each time the stage starts
	
		logger.Warning(GAMEMODE_STAGES_PREFIX .. 
		"\"" .. stageName .. "\" Start method not overwritten.")
	
	end
	----------------------------------------------------------------------------
	
	
	-- [StageEnd Method] -------------------------------------------------------
	function self.StageEnd()
	
		-- Override this in your object if you want specific things to 
		-- happen each time the stage ends
	
		logger.Warning(GAMEMODE_STAGES_PREFIX .. 
		"\"" .. stageName .. "\" End method not overwritten.")

		return false
	
	end
	----------------------------------------------------------------------------

	
	return self

end
--------------------------------------------------------------------------------