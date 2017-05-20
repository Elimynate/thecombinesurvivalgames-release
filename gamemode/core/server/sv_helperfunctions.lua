--------------------------------------------------------------------------------
-- [ShufleTable Function] -- Shuffle a given table randomly
--------------------------------------------------------------------------------
function ShuffleTable(table)

	math.randomseed(os.time())

    local rand = math.random
    local iterations = #table
    local j
    
    for i = iterations, 2, -1 do
        j = rand(i)
        table[i], table[j] = table[j], table[i]
    end

end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [FindPlayer Function] -- Find player by name and return player
--------------------------------------------------------------------------------
function FindPlayer(name)

	-- Table of all players
    local players = player.GetAll()
	
	-- Loop through all players till the requested player is found
    for k, v in pairs(players) do
	
        if(string.find(string.lower(v:GetName()), 
		string.lower(tostring(name)), 1, true) ~= nil) then
			return v
        end
		
    end
	
    return nil
	
end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [SpawnEmptyCrate Function] -- Drop a crate in the world at a position and
-- return a reference to it
--------------------------------------------------------------------------------
function SpawnEmptyCrate(parentLootPointForCrateIndex, pos, itemsTier)

	-- Create a wooden crate
	local crate = ents.Create("prop_physics")
	crate.identifier = itemIdentifier
	crate:SetModel("models/items/item_item_crate.mdl")
	crate:SetPos(pos)
	crate:Spawn()
	crate:SetHealth(1)
	crate:Activate()
	
	-- Set the wooden crates lootPointIndex to point to the entity index
	-- of the info_target hammer editor entity that acts
	-- as a reference point for loot crates in the world
	crate.lootPointIndex = parentLootPointForCrateIndex
	crate.lootTier = itemsTier
	
	-- Return the wooden crates own entity index (as the physics prop
	-- is seperate to the info_target entity). This way we can check
	-- that when a prop is destroyed, if it has a lootPointIndex it means
	-- it will spawn an item 
	return crate:EntIndex()
	
end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [TransitionFadeAllPlayers Function]
--------------------------------------------------------------------------------
function TransitionFadeAllPlayers(amount)

	if(amount == nil) then amount = 1 end
	-- Given an amount in seconds to fade the screen for
	-- split that in two so half is spent on the fade transition
	-- and the other half is the screen in black
	local splitAmount = amount/2
	
	for k, ply in pairs(player.GetAll()) do
		ply:ScreenFade(	SCREENFADE.IN, 
						Color(0, 0, 0, 255), 
						splitAmount, 
						splitAmount)
	end
	
end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [SilentKillAllPlayers Function]
--------------------------------------------------------------------------------
function SilentKillAllLivePlayers()
	
	for k, ply in pairs(player.GetAll()) do

		if(ply:Alive()) then

			ply:KillSilent()

		end

	end
	
end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [SpawnAllPlayers Function]
--------------------------------------------------------------------------------
function SpawnAllDeadPlayers()
	
	for k, ply in pairs(player.GetAll()) do

		if(!ply:Alive()) then

			ply:Spawn()
			ply:LoadOut()

		end
		
	end
	
end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [NormalColourAllPlayers Function]
--------------------------------------------------------------------------------
function NormalColourAndDefaultCollideAllPlayers()
	
	for k, ply in pairs(player.GetAll()) do

		ply:SetRenderMode(RENDERMODE_NORMAL)
		ply:SetColor(Color(255, 255, 255, 255))

		ply:SetCollisionGroup(COLLISION_GROUP_PLAYER)
		
	end
	
end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [AlphaColourAllPlayers Function]
--------------------------------------------------------------------------------
function AlphaColourAndNoCollideAllPlayers()
	
	for k, ply in pairs(player.GetAll()) do

		ply:SetRenderMode(RENDERMODE_TRANSALPHA)
		ply:SetColor(Color(255, 255, 255, 150))

		ply:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		
	end
	
end
--------------------------------------------------------------------------------