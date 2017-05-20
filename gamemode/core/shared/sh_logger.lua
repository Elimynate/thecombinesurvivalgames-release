--------------------------------------------------------------------------------
-- [Logger Object]
--------------------------------------------------------------------------------
-- A logger that outputs a message with a printed timestamp and a specific 
-- prefix such as [INFO], [WARNING] or [ERROR]
Logger = {}

Logger.new = function()

	local self = {}
	
	
	-- [Info Method] -----------------------------------------------------------
	self.Info = function(arg)
	
		-- If the config doesn't have logger functionality enabled then
		-- do nothing
		if(!TCSG.EnableLogger) then return end
		
		local time = os.time()
		local timeReadable = os.date( "%H:%M:%S" , time)
		print(string.format("[%s] %-8s", 
		timeReadable, "[INFO") .. "]\t" .. arg)
	
	end
	----------------------------------------------------------------------------
	
	
	-- [Warning Method] -----------------------------------------------------
	self.Warning = function(arg)
	
		-- If the config doesn't have logger functionality enabled then
		-- do nothing
		if(!TCSG.EnableLogger) then return end
	
		local time = os.time()
		local timeReadable = os.date( "%H:%M:%S" , time)
		print(string.format("[%s] %-8s", 
		timeReadable, "[WARNING") .. "]\t" .. arg)
	
	end
	----------------------------------------------------------------------------
	
	
	-- [Error Method] -----------------------------------------------------
	self.Error = function(arg)
	
		-- If the config doesn't have logger functionality enabled then
		-- do nothing
		if(!TCSG.EnableLogger) then return end
	
		local time = os.time()
		local timeReadable = os.date( "%H:%M:%S" , time)
		print(string.format("[%s] %-8s", 
		timeReadable, "[ERROR") .. "]\t" .. arg)
	
	end
	----------------------------------------------------------------------------

	
	return self

end
--------------------------------------------------------------------------------
-- Global logger variable so we can call it anywhere
logger = Logger.new()
--------------------------------------------------------------------------------