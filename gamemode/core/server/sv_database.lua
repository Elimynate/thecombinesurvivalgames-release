--------------------------------------------------------------------------------
-- [Declare Variables]
--------------------------------------------------------------------------------
local startingVictories = 0
local startingTokens = 0
local startingKills = 0
local startingDeaths = 0
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [CheckForTableExistence Function]
--------------------------------------------------------------------------------
function CheckForTableExistence()
	
	-- Check if Player table exists in database and either create it if it
	-- doesn't, or continue as normal if it does
	if(sql.TableExists("Player")) then
		logger.Info(GAMEMODE_CORE_PREFIX .. 
		"Player table exists in the database.")
	else
		logger.Warning(GAMEMODE_CORE_PREFIX .. 
		"Player table does not exist in the database.")
		
		queryResult = sql.Query("CREATE TABLE Player ( " ..
								"SteamID varchar(255), " ..
								"LastKnownName varchar(255), " ..
								"Victories int, " ..
								"Tokens int, " ..
								"Kills int, " ..
								"Deaths int)")
		
		if(sql.TableExists("Player")) then
			logger.Info(GAMEMODE_CORE_PREFIX .. 
			"Player table successfully created.")
		else
			if(!queryResult) then
				print(GAMEMODE_MESSAGES_PREFIX_ERROR ..
				"There was a problem creating the database.")
			end
		end
	end
	
end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [Initialize Function]
--------------------------------------------------------------------------------
function InitializeDatabase()
	CheckForTableExistence()
end
hook.Add("PostGamemodeLoaded", "InitializeDatabase", InitializeDatabase)
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- [AddNewPlayerInfoToDatabase Function]
--------------------------------------------------------------------------------
function AddNewPlayerToDatabase(ply)
	
	-- Add a new player to the database
	sql.Query("INSERT INTO Player (SteamID, LastknownName, Victories, " ..
				"Tokens, Kills, Deaths) " ..
				"VALUES ('" .. ply:SteamID() .. "', '" ..
				ply:GetName() .. "', " .. startingVictories .. ", " .. 
				startingTokens .. ", " .. startingKills .. ", "
				.. startingDeaths .. " )")
							
	queryResult = sql.Query("SELECT * FROM Player " ..
							"WHERE SteamID = '" .. ply:SteamID() .. "'")						
							
	if(queryResult) then
		logger.Info(GAMEMODE_CORE_PREFIX ..
		"Player " .. ply:GetName() .. " added to database.")
	else
		logger.Error(GAMEMODE_CORE_PREFIX ..
		"There was a problem in adding " .. ply:GetName() .. 
		" to the database.")
	end		
		
end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [UpdatePlayerInfo Function]
--------------------------------------------------------------------------------
function UpdatePlayerLastKnownNick(ply)
	
	-- Update player last known name upon joining
	queryResult = sql.Query("UPDATE Player " ..
							"SET LastKnownName = '" .. ply:GetName() .. "' " ..
							"WHERE SteamID = '" .. ply:SteamID() .. "'")		

	logger.Info(GAMEMODE_CORE_PREFIX ..
	"Player " .. ply:GetName() .. "'s last known name updated in database.")							
	
end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [RetrievePlayerStatsFromDatabase Function]
--------------------------------------------------------------------------------
function RetrievePlayerStatsFromDatabase(ply)
	
	-- Retrieve player stats
	ply:SetNWInt("victories", sql.QueryValue("SELECT Victories " .. 
										"FROM Player " ..
										"WHERE SteamID = '" .. 
										ply:SteamID() .. "'"))
	
	ply:SetNWInt("tokens", sql.QueryValue("SELECT Tokens " .. 
										"FROM Player " ..
										"WHERE SteamID = '" .. 
										ply:SteamID() .. "'"))

	ply:SetNWInt("kills", sql.QueryValue("SELECT Kills " .. 
										"FROM Player " ..
										"WHERE SteamID = '" .. 
										ply:SteamID() .. "'"))

	ply:SetNWInt("deaths", sql.QueryValue("SELECT Deaths " .. 
										"FROM Player " ..
										"WHERE SteamID = '" .. 
										ply:SteamID() .. "'"))

end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [SavePlayerStatsToDatabase Function]
--------------------------------------------------------------------------------
function SavePlayerStatsToDatabase(ply)

	-- Save player stats
	queryResult = sql.Query("UPDATE Player " ..
							"SET Victories = " .. ply:GetNWInt("victories") .. ", " ..
							"Tokens = " .. ply:GetNWInt("tokens") .. ", " ..
							"Kills = " .. ply:GetNWInt("kills") .. ", " ..
							"Deaths = " .. ply:GetNWInt("deaths") .. " " ..
							"WHERE SteamID = '" .. ply:SteamID() .. "'")
	
end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [PlayerFirstJoin Function]
--------------------------------------------------------------------------------
function PlayerFirstJoin(ply)

	-- Upon player initial spawn, set a timer to allow player to initialise
	timer.Create("steamIDDelayTimer", 1, 1, function()
		
		if(ply:IsValid()) then
			queryResult = sql.Query("SELECT * FROM Player " ..
									"WHERE SteamID = '" .. ply:SteamID() .. "'")
									
			if(queryResult) then
				logger.Info(GAMEMODE_CORE_PREFIX ..
				"Player " .. ply:GetName() .. 
				" exists in the database, retrieving their info.")
				UpdatePlayerLastKnownNick(ply)
				RetrievePlayerStatsFromDatabase(ply)
			else
				logger.Info(GAMEMODE_CORE_PREFIX ..
				"Adding new player " .. ply:GetName() .. " to database.")
				AddNewPlayerToDatabase(ply)
			end
		end
		
	end)
	
end
hook.Add("PlayerInitialSpawn", "PlayerFirstJoin", PlayerFirstJoin)
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [SavePlayerStatsToDatabase Function]
--------------------------------------------------------------------------------
function GetPlayerWithMostVictories(ply)

	-- Query
	queryResult = sql.Query(
		"SELECT LastKnownName, Victories FROM Player " ..
		"WHERE Victories IN (SELECT MAX(Victories) FROM Player)")

	if(queryResult) then

		return queryResult

	else

		return nil

	end
	
end
--------------------------------------------------------------------------------