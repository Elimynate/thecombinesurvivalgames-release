--------------------------------------------------------------------------------
-- [Declare Variables]
--------------------------------------------------------------------------------
local ply = FindMetaTable("Player")
local minStamina = 0
local maxStamina = 100
local plyRunSpeed = 400
local plyWalkSpeed = 200
local plyDefaultJumpPower = 160
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [SetupFirstTimeJoin Function]
--------------------------------------------------------------------------------
function ply:SetupFirstTimeJoin()
	
	-- Assign a player to a City team upon joining
	local plyBeenAssigned = false
	local teamToAssignPlayer = 1
	
	-- Assign player to the next available City team
	while(!plyBeenAssigned) do
		
		-- if the team is a valid team and the current number of players in
		-- that team is less than 2
		if(team.Valid(teamToAssignPlayer)
		&& (team.NumPlayers(teamToAssignPlayer) < 2) 
		&& (teamToAssignPlayer <= 12)) then
			
			-- Then assign player to that team
			plyBeenAssigned = true
			self:SetTeam(teamToAssignPlayer)
			self:ChatPrint("You have been assigned to team " ..
							team.GetName(self:Team()))
			
		else
		
			-- Otherwise increment the team to assign the player to by one
			if(teamToAssignPlayer >= 13) then 
				break
			else
				teamToAssignPlayer = teamToAssignPlayer + 1
			end
		
		end
		
	end
	
	-- Initialise variables
	self:SetKeyValue("targetname", self:SteamID())
	
end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [SetPlayerModel Function]
--------------------------------------------------------------------------------
function ply:SetPlayerModel()
	
	-- Set the player model when they spawn and colours it according
	-- to their team colour
	self:SetModel("models/player/group03/male_09.mdl")
	self:SetupHands()
	local tempColor = team.GetColor(self:Team())
	self:SetPlayerColor(Vector(	tempColor.r/255, 
								tempColor.g/255, 
								tempColor.b/255))
	
end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [LoadOut Function]
--------------------------------------------------------------------------------
function ply:LoadOut()
	
	-- Called everytime a player spawns. It gives them a specific loadout
	-- and sets appropriate variables
	self:StripWeapons()
	self:StripAmmo()
	
	self:Give("weapon_fists")
	self:SetHealth(100)
	self:SetArmor(0)

	self:SetRunSpeed(plyRunSpeed)
	self:SetWalkSpeed(plyWalkSpeed)

	self:SetNWInt("stamina", 100)
	self.isSpectating = false

	self:GodDisable()
	self:SetArmor(25)

end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [GoIntoSpectateMode Function]
--------------------------------------------------------------------------------
function ply:GoIntoSpectateMode()

	self.speccedPlayers = {}

	for k, p in pairs(player.GetAll()) do

		if(p ~= self 
		&& p:Alive() 
		&& !p.isSpecating
		&& self.speccedPlayers[p:GetName()] == nil) then

			self:StripAmmo()
			self:StripWeapons()
			self:SpectateEntity(p)
			self:Spectate(OBS_MODE_CHASE)
			self.isSpectating = true
			self.speccedPlayers[p:GetName()] = p
			break
			
		end

	end
	
end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [SpectateMode Function]
--------------------------------------------------------------------------------
function ply:SpectateMode()

	
	if(self:GetObserverTarget() && !self:GetObserverTarget():Alive()) then

		for k, p in pairs(player.GetAll()) do

			if(p ~= self 
			&& p:Alive() 
			&& !p.isSpectating 
			&& self.speccedPlayers[p:GetName()] == nil) then

				self:SpectateEntity(p)
				self.speccedPlayers = {}
				self.speccedPlayers[p:GetName()] = p
				break
				
			end

		end

	end

	if(self:KeyPressed(IN_ATTACK)) then
		
		local countSpeccedPlayers = 0

		for k, v in pairs(self.speccedPlayers) do

			countSpeccedPlayers = countSpeccedPlayers + 1

		end

		if(countSpeccedPlayers >= #player.GetAll() - 1) then

			self.speccedPlayers = {}

		end

		for k, p in pairs(player.GetAll()) do

			if(p ~= self 
			&& p:Alive() 
			&& !p.isSpecating
			&& self.speccedPlayers[p:GetName()] == nil) then

				self.speccedPlayers[p:GetName()] = p
				self:SpectateEntity(p)
				break

			end

		end

	end
	
end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [NeedsHealing Function]
--------------------------------------------------------------------------------
function ply:NeedsHealing()
	
	-- Check if the player is in need of healing
	return (self:Health() < self:GetMaxHealth())
	
end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [Heal Function]
--------------------------------------------------------------------------------
function ply:Heal(amount)
	
	--Heal the player for a given amount
	if(!self:NeedsHealing()) then return end
	
	local maxHealth = self:GetMaxHealth()
	
	if((self:Health() + amount) > maxHealth) then
		self:SetHealth(maxHealth)
	else
		self:SetHealth(self:Health() + amount)
	end
	
end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [SetNamedData Function]
--------------------------------------------------------------------------------
function ply:SetNamedData(namedData, amount)
	
	-- Set a networked variable on the player by a given name to a
	-- certain amount
	if(self:IsPlayer()) then
		self:SetNWInt(namedData, tonumber(amount))
		logger.Info(GAMEMODE_CORE_PREFIX .. "Player " .. 
		self:GetName() ..
		" " .. namedData .. " set to " .. amount .. ".")
		SavePlayerStatsToDatabase(self)
	end

end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [HasNamedData Function]
--------------------------------------------------------------------------------
function ply:HasNamedData(namedData, amount)
	
	-- Check if a named networked variable on a player is atleast equal or
	-- less than the specified amount
	if(self:IsPlayer()) then
		local plyData = self:GetNWInt(namedData)
		if(!plyData) then return false end
		if(plyData >= amount) then
			return true
		else
			return false
		end
	end

end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [AddNamedData Function]
--------------------------------------------------------------------------------
function ply:AddNamedData(namedData, amount)
	
	-- Add an amount to a networked variable on the player
	if(self:IsPlayer()) then
		local plyData = self:GetNWInt(namedData)
		self:SetNWInt(namedData, ( plyData + tonumber(amount)))
		logger.Info(GAMEMODE_CORE_PREFIX .. amount .. " added to player " ..
		self:GetName() .. "'s " .. namedData .. ".")
		SavePlayerStatsToDatabase(self)
	end

end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [SubtractNamedData Function]
--------------------------------------------------------------------------------
function ply:SubtractNamedData(namedData, amount)
	
	-- Subtract an amount to a networked variable on the player
	if(self:IsPlayer()) then
		local plyData = self:GetNWInt(namedData)
		self:SetNWInt(namedData, ( plyData - tonumber(amount)))
		logger.Info(GAMEMODE_CORE_PREFIX .. amount .. 
		" subtracted from player " .. self:GetName() .. 
		"'s " .. namedData .. ".")
		SavePlayerStatsToDatabase(self)
	end

end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [Player Stamina System]
--------------------------------------------------------------------------------
hook.Add("KeyPress", "StaminaBarStart", function(ply, key)

	if(ply:InVehicle()) then return end
	if(ply:GetMoveType() == MOVETYPE_NOCLIP) then return end
	if(ply:GetMoveType() == MOVETYPE_FLY) then return end
	if(ply:GetMoveType() == MOVETYPE_FLYGRAVITY) then return end
	if(ply:GetMoveType() == MOVETYPE_LADDER) then return end

	if(key == IN_SPEED && ply:KeyDown(IN_SPEED)) then

		local plyVelocity = ply:GetVelocity()

		if(plyVelocity.x >= plyWalkSpeed/2
			|| plyVelocity.x <= -plyWalkSpeed/2
			|| plyVelocity.y >= plyWalkSpeed/2
			|| plyVelocity.y <= -plyWalkSpeed/2) then

			local plyStamina = ply:GetNWInt("stamina")

			if(plyStamina > 0) then

				timer.Remove("StaminaRegen")

				ply:SetRunSpeed(plyRunSpeed)

				ply:SendLua("surface.PlaySound('player/suit_sprint.wav')")

				if(!timer.Exists("StaminaUse")) then

					timer.Create("StaminaUse", 0.1, 0, function()

						local plyStaminaInTimer = ply:GetNWInt("stamina")

						if(plyStaminaInTimer <= 0) then

							timer.Remove("StaminaUse")

							ply:SetRunSpeed(plyWalkSpeed)

							ply:SetNWInt("stamina", 0)

							return false

						end

						ply:SetNWInt("stamina", plyStaminaInTimer - 1)

					end)

				end

			else

				timer.Remove("StaminaUse")

				ply:SetRunSpeed(plyWalkSpeed)

			end

		end

	end

end) 
--------------------------------------------------------------------------------
hook.Add("KeyRelease", "StaminaBarStop", function(ply, key)

	if((key == IN_SPEED 
		|| key == IN_FORWARD 
		|| key == IN_BACK 
		|| key == IN_LEFT 
		|| key == IN_RIGHT) && !ply:KeyDown(IN_SPEED)) then

		timer.Remove("StaminaUse")

		if(!timer.Exists("StaminaRegen")) then

			timer.Create("StaminaRegen", 0.1, 0, function()

				local plyStamina = ply:GetNWInt("stamina")

				if(plyStamina >= 100) then

					ply:SetNWInt("stamina", 100)
					return false

				else

					ply:SetNWInt("stamina", plyStamina + 2)

				end

			end)
			
		end

	end

end)
--------------------------------------------------------------------------------