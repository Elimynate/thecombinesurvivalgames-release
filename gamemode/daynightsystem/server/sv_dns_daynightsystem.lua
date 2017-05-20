--------------------------------------------------------------------------------
-- [Declare Variables]
--------------------------------------------------------------------------------
local SECOND = 1/60
local MINUTE = 60 * SECOND
local HOUR = 60 * MINUTE
local DAY = HOUR * 24

local START_OF_DAY = 0 -- 00:00

local START_OF_DAWN = 5 * HOUR + 45 * MINUTE -- 05:45
local END_OF_DAWN = 5 * HOUR + 59 * MINUTE -- 05:59

local START_OF_MORNING = 6 * HOUR -- 06:00
local END_OF_MORNING = 11 * HOUR + 59 * MINUTE -- 11:59

local START_OF_AFTERNOON = 12 * HOUR -- 12:00
local END_OF_AFTERNOON = 19 * HOUR + 44 * MINUTE -- 19:44

local START_OF_DUSK = 19 * HOUR + 45 * MINUTE -- 19:45
local END_OF_DUSK = 19 * HOUR + 59 * MINUTE -- 19:59

local START_OF_EVENING = 20 * HOUR -- 20:00
local END_OF_EVENING = 23 * HOUR + 59 * MINUTE -- 23:59

local LIGHT_DARKEST_VALUE = 'a'
local LIGHT_BRIGHTEST_VALUE = 'z'
local LIGHT_NIGHT_VALUE = 'a'
local LIGHT_DAY_VALUE = 'r'
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [DayNightSystem Object]
--------------------------------------------------------------------------------
DayNightSystem = {}

DayNightSystem.New = function()
	
	local self = {}
	
	
	-- [Private Class Variables] -----------------------------------------------
	lightEnvironments = ents.FindByClass("light_environment")
	lightEnvironment = lightEnvironments[1]
	
	suns = ents.FindByClass("env_sun")
	sun = suns[1]
	
	hasBeenInitialised = false
	----------------------------------------------------------------------------
	

	-- [Init Method] -----------------------------------------------------------
	self.Init = function()
	
		if(IsValid(lightEnvironment)) then
			lightEnvironment:Fire('SetPattern', LIGHT_DARKEST_VALUE, 0)
			lightEnvironment:Activate()
		end
		
		hasBeenInitialised = true
	
	end
	----------------------------------------------------------------------------

	
	-- [Start Method] ----------------------------------------------------------
	self.Start = function()
	
		
	
	end
	----------------------------------------------------------------------------
	
	
	-- [Update Method] ---------------------------------------------------------
	self.Update = function()
	
		if(hasBeenInitialised && IsValid(sun)) then
			
			sun:Fire("TurnOff")
			
		end
	
	end
	----------------------------------------------------------------------------

	
	return self
	
end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
dayNightSystem = DayNightSystem.New()
--------------------------------------------------------------------------------