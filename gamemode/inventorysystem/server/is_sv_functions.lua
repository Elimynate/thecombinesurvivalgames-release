--------------------------------------------------------------------------------
-- [Declare Variables]
--------------------------------------------------------------------------------
local ent = FindMetaTable("Player")
--------------------------------------------------------------------------------




--------------------------------------------------------------------------------
-- [DropItemInWorld Function] -- Drop a named item in the world at a position
-- return a reference to it
--------------------------------------------------------------------------------
function DropItemInWorld(item, pos)

	local itemToDrop = ents.Create(item.GetItemType())
	itemToDrop.identifier = item.GetItemIdentifier()
	itemToDrop:SetModel(item.GetItemModel())
	itemToDrop:SetSkin(item.GetItemSkin())
	itemToDrop:SetPos(pos)
	itemToDrop:Spawn()
	itemToDrop:Activate()
	
	return itemToDrop:EntIndex()
	
end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [SetupInventory]
--------------------------------------------------------------------------------
function ent:SetupInventory(noOfSlots)
	
	-- setup the inventory table on the entity
	self.inventory = Inventory(self, noOfSlots)
	self.inventory.Setup()
	
end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [DropAllFromInventory]
--------------------------------------------------------------------------------
function ent:DropAllFromInventory()
	
	-- Drops all items from the players inventory. For items that are
	-- stacked it only drops one for that item
	self.inventory.DropAllItems()
	
end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [TakeFromInventory]
--------------------------------------------------------------------------------
function ent:TakeFromInventory(slot, item, amount)
	
	-- Try take an item from a players inventory given a slot,
	-- identifier and amount to remove
	return self.inventory.TakeItem(slot, item, amount)
	
end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [AddToInventory]
--------------------------------------------------------------------------------
function ent:AddToInventory(item, amount)
	
	return self.inventory.AddItem(item, amount)
	
end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [TryAddItemPlayerIsLookingAtToInventory]
--------------------------------------------------------------------------------
hook.Add("KeyPress", "ClientPressedKeyE", function(ply, key)
	
	if(key == IN_USE) then

		-- Get a trace of what the player is looking at
		local trace = {}
		trace.start = ply:EyePos()
		trace.endpos = trace.start + ply:GetAimVector() * 128
		trace.filter = ply
		local tr = util.TraceLine(trace)
		
		-- If the trace hit the world then it isn't an item
		if(tr.HitWorld) then return end
		-- If the trace isn't an entity then do nothing
		if(!tr.Entity:IsValid()) then return end
		-- If the trace has the identifier attached to it we know it is a valid
		-- item that the gamemode created
		if(tr.Entity.identifier) then
		
			-- Get the identifier (which is unique for each item)
			local itemIdentifier = tr.Entity.identifier
			
			-- If the items repository contains this item
			if(itemsRepository.ContainsItem(itemIdentifier)) then
			
				local itemFromRepo = itemsRepository.GetItem(itemIdentifier)
				
				-- Try add it to the players inventory and remove it from the world
				if(ply.inventory.AddItem(itemFromRepo, 1)) then
				
					tr.Entity:Remove()
					
					ply:ChatPrint(
					itemFromRepo.GetItemName() .. 
					" added to your inventory.")
					
				else

					-- Otherwise let the player know it wasn't possible
					ply:ChatPrint("Your inventory is full!")

				end
				
			end
			
		end

	end
	
end)
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [Net ClientRequestInventoryUpdate]
--------------------------------------------------------------------------------
net.Receive("ClientRequestInventoryUpdate", function(len, ply)
	
	ply:ForceClientSideInventoryUpdate()

end)
--------------------------------------------------------------------------------


function ent:ForceClientSideInventoryUpdate()

    -- Send a net message to the client so they can get an updated version
	-- of their inventory
	net.Start("ClientReceiveInventoryUpdate")
	net.WriteInt(self.inventory.GetNumberOfSlots(), 16)

	local slots = self.inventory.GetSlots()

	for i = 1, self.inventory.GetNumberOfSlots() do
		net.WriteString(slots[i].GetSlotName())
		net.WriteBool(slots[i].GetSlotIsEmpty())
		net.WriteString(slots[i].GetItemInSlot())
		net.WriteInt(slots[i].GetItemInSlotCount(), 16)
	end
	
	net.Send(self)

end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [Net ClientRequestDropItem]
--------------------------------------------------------------------------------
net.Receive("ClientRequestDropItem", function(len, ply)

	-- Whenever a client requests to drop an item, the server checks if
	-- that is possible
	local slotName = net.ReadString()
	local itemToDrop = net.ReadString()
	
	local itemFromRepo = itemsRepository.GetItem(itemToDrop)
	
	-- Client has requested to drop a specified item, so try that
	if(itemFromRepo && ply.inventory.TakeItem(slotName, itemFromRepo, 1)) then
		itemFromRepo.Drop(ply)
	end
	
end)
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [Net ClientRequestUseItem]
--------------------------------------------------------------------------------
net.Receive("ClientRequestUseItem", function(len, ply)

	-- Whenever a client requests to use an item, the server checks if
	-- that is possible
	local slotName = net.ReadString()
	local itemToDrop = net.ReadString()
	
	local itemFromRepo = itemsRepository.GetItem(itemToDrop)
	
	-- Client has requested to use a specified item, so try that
	if(itemFromRepo && ply.inventory.TakeItem(slotName, itemFromRepo, 1)) then
		if(itemFromRepo.AlreadyUsed(ply)) then
			itemFromRepo.UseAndAlreadyUsed(ply)
		else
			itemFromRepo.Use(ply)
		end
	end

	
end)
--------------------------------------------------------------------------------