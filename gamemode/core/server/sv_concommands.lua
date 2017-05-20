--------------------------------------------------------------------------------
-- Table of commands to make add, set and whatever other concommands for
--------------------------------------------------------------------------------
local conCommandsToAdd = {"victories", "tokens"}
--------------------------------------------------------------------------------
-- [Concommands Add] -- for each of the values in the conCommandsToAdd table
-- we add a _add concommand for it
--------------------------------------------------------------------------------
for commandKey, commandValue in pairs(conCommandsToAdd) do

	concommand.Add(

	-- Name of the concommand
	"tcsg_" .. commandValue .. "_add", 
	
	-- Function to execute when the concommand is called
	function(ply, cmd, args)
		if(!ply:IsAdmin()) then 
		
			ply:ChatPrint(GAMEMODE_ADMIN_PREFIX .. 
			"You are not an admin, you cannot use that command!")

			logger.Info(GAMEMODE_CORE_PREFIX ..
				ply:GetName() .. " tried to use tcsg_" .. 
				commandValue .. "_add." )
				
		else
		
			local playerToAffect = FindPlayer(args[1])
			local amountToAdd = tonumber(args[2])
			
			if(playerToAffect and amountToAdd) then
			
				playerToAffect:AddNamedData(commandValue, amountToAdd)
				ply:ChatPrint(GAMEMODE_ADMIN_PREFIX .. 
				"You added " .. amountToAdd .. " to " .. 
				playerToAffect:GetName() .. "'s " .. commandValue .. ".")
				
				playerToAffect:ChatPrint(GAMEMODE_ADMIN_PREFIX .. 
				ply:GetName() .. " (Admin) added " .. amountToAdd .. 
				" to your " .. commandValue)
				
			end
		end
	end,
	
	-- Function for helping the autocompletion of a concommand in console
	function(cmd, stringargs)

		stringargs = string.Trim( stringargs )
		stringargs = string.lower( stringargs )

		local tbl = {}

		for k, v in pairs( player.GetAll() ) do
			local plyName = v:GetName()
			if(string.find( string.lower( plyName ), stringargs)) then
				plyName = "\"" .. plyName .. "\" "
				plyName = "tcsg_" .. commandValue .. "_add " .. plyName
				table.insert( tbl, plyName )
			end
		end

		return tbl
		
	end)

end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- [Concommands Set] -- for each of the values in the conCommandsToAdd table
-- we add a _add concommand for it
--------------------------------------------------------------------------------
for commandKey, commandValue in pairs(conCommandsToAdd) do

	concommand.Add(

	-- Name of the concommand
	"tcsg_" .. commandValue .. "_set", 
	
	-- Function to execute when the concommand is called
	function(ply, cmd, args)
		if(!ply:IsAdmin()) then 
		
			ply:ChatPrint(GAMEMODE_ADMIN_PREFIX .. 
			"You are not an admin, you cannot use that command!")

			logger.Info(GAMEMODE_CORE_PREFIX ..
				ply:GetName() .. " tried to use tcsg_" .. 
				commandValue .. "_set." )
				
		else
		
			local playerToAffect = FindPlayer(args[1])
			local amountToSet = tonumber(args[2])
			
			if(playerToAffect and amountToSet) then
			
				playerToAffect:AddNamedData(commandValue, amountToSet)
				ply:ChatPrint(GAMEMODE_ADMIN_PREFIX .. 
				"You set " .. playerToAffect:GetName() .. "'s " .. 
				commandValue .. " to " .. amountToSet .. ".")
				
				playerToAffect:ChatPrint(GAMEMODE_ADMIN_PREFIX .. 
				ply:GetName() .. " (Admin) set your " .. commandValue .. 
				" to " .. amountToSet)
				
			end
		end
	end,
	
	-- Function for helping the autocompletion of a concommand in console
	function(cmd, stringargs)

		stringargs = string.Trim( stringargs )
		stringargs = string.lower( stringargs )

		local tbl = {}

		for k, v in pairs( player.GetAll() ) do
			local plyName = v:GetName()
			if(string.find( string.lower( plyName ), stringargs)) then
				plyName = "\"" .. plyName .. "\" "
				plyName = "tcsg_" .. commandValue .. "_set " .. plyName
				table.insert( tbl, plyName )
			end
		end

		return tbl
		
	end)

end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- [Concommands Subtract] -- for each of the values in the conCommandsToAdd table
-- we add a _add concommand for it
--------------------------------------------------------------------------------
for commandKey, commandValue in pairs(conCommandsToAdd) do

	concommand.Add(

	-- Name of the concommand
	"tcsg_" .. commandValue .. "_subtract", 
	
	-- Function to execute when the concommand is called
	function(ply, cmd, args)
		if(!ply:IsAdmin()) then 
		
			ply:ChatPrint(GAMEMODE_ADMIN_PREFIX .. 
			"You are not an admin, you cannot use that command!")

			logger.Info(GAMEMODE_CORE_PREFIX ..
				ply:GetName() .. " tried to use tcsg_" .. 
				commandValue .. "_subtract." )
				
		else
		
			local playerToAffect = FindPlayer(args[1])
			local amountToSubtract = tonumber(args[2])
			
			if(playerToAffect and amountToSubtract) then
			
				playerToAffect:AddNamedData(commandValue, amountToSubtract)
				ply:ChatPrint(GAMEMODE_ADMIN_PREFIX .. 
				"You subtracted " .. amountToSubtract .. " from " .. 
				playerToAffect:GetName() .. "'s " .. commandValue .. ".")
				
				playerToAffect:ChatPrint(GAMEMODE_ADMIN_PREFIX .. 
				ply:GetName() .. " (Admin) subtracted " .. amountToSubtract .. 
				" from your " .. commandValue)
				
			end
		end
	end,
	
	-- Function for helping the autocompletion of a concommand in console
	function(cmd, stringargs)

		stringargs = string.Trim( stringargs )
		stringargs = string.lower( stringargs )

		local tbl = {}

		for k, v in pairs( player.GetAll() ) do
			local plyName = v:GetName()
			if(string.find( string.lower( plyName ), stringargs)) then
				plyName = "\"" .. plyName .. "\" "
				plyName = "tcsg_" .. commandValue .. "_subtract " .. plyName
				table.insert( tbl, plyName )
			end
		end

		return tbl
		
	end)

end
--------------------------------------------------------------------------------
-- [Concommand Kick] 
--------------------------------------------------------------------------------
concommand.Add(

	-- Name of the concommand
	"tcsg_kick", 
	
	-- Function to execute when the concommand is called
	function(ply, cmd, args)
		if(!ply:IsAdmin()) then 
		
			ply:ChatPrint(GAMEMODE_ADMIN_PREFIX .. 
			"You are not an admin, you cannot use that command!")

			logger.Info(GAMEMODE_CORE_PREFIX ..
				ply:GetName() .. " tried to use tcsg_" .. 
				commandValue .. "_kick." )
				
		else
		
			local playerToAffect = FindPlayer(args[1])
			local reason = FindPlayer(args[2])
			print(reason)
			if(playerToAffect ) then
			
				ply:ChatPrint(GAMEMODE_ADMIN_PREFIX .. 
				"You kicked " .. playerToAffect:GetName())
				
				playerToAffect:ChatPrint(GAMEMODE_ADMIN_PREFIX .. 
				ply:GetName() .. " (Admin) is kicking you")
				
				playerToAffect:Kick(reason)
				
			end
		end
	end,
	
	-- Function for helping the autocompletion of a concommand in console
	function(cmd, stringargs)

		stringargs = string.Trim( stringargs )
		stringargs = string.lower( stringargs )

		local tbl = {}

		for k, v in pairs( player.GetAll() ) do
			local plyName = v:GetName()
			if(string.find( string.lower( plyName ), stringargs)) then
				plyName = "\"" .. plyName .. "\" "
				plyName = "tcsg_" .. commandValue .. "_subtract " .. plyName
				table.insert( tbl, plyName )
			end
		end

		return tbl
		
end)
--------------------------------------------------------------------------------