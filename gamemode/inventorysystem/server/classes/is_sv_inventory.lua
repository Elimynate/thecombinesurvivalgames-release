--------------------------------------------------------------------------------
-- [Slot Object]
--------------------------------------------------------------------------------
local function Slot(slotName, slotIsEmpty, itemInSlot, itemInSlotCount)

	local self = {}


	-- [Private Class Variables] -----------------------------------------------
	local slotName = slotName
	local slotIsEmpty = slotIsEmpty
	local itemInSlot = itemInSlot
	local itemInSlotCount = itemInSlotCount
	----------------------------------------------------------------------------


	-- [Setters] ---------------------------------------------------------------
	function self.SetSlotName(arg)
		slotName = arg
	end

	function self.SetSlotIsEmpty(arg)
		slotIsEmpty = arg
	end

	function self.SetItemInSlot(arg)
		itemInSlot = arg
	end

	function self.SetItemInSlotCount(arg)
		itemInSlotCount = arg
	end
	----------------------------------------------------------------------------


	-- [Getters] ---------------------------------------------------------------
	function self.GetSlotName()
		return slotName
	end

	function self.GetSlotIsEmpty()
		return slotIsEmpty
	end

	function self.GetItemInSlot()
		return itemInSlot
	end

	function self.GetItemInSlotCount()
		return itemInSlotCount
	end
	----------------------------------------------------------------------------


	-- [ClearSlot] -------------------------------------------------------------
	function self.ClearSlot()

		slotIsEmpty = true
		itemInSlot = ""
		itemInSlotCount = 0

	end
	----------------------------------------------------------------------------


	return self

end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [Inventory Object]
--------------------------------------------------------------------------------
function Inventory(entityInventoryIsAttachedTo, numberOfSlots)

	local self = {}


	-- [Private Class Variables] -----------------------------------------------
	local entityInventoryIsAttachedTo = entityInventoryIsAttachedTo
	local numberOfSlots = numberOfSlots
	local slots = {}
	----------------------------------------------------------------------------


	-- [Setters] ---------------------------------------------------------------
	function self.SetEntityInventoryIsAttachedTo(arg)
		entityInventoryIsAttachedTo = arg
	end

	function self.SetNumberOfSlots(arg)
		numberOfSlots = arg
	end

	function self.SetSlots(arg)
		slots = arg
	end
	----------------------------------------------------------------------------


	-- [Getters] ---------------------------------------------------------------
	function self.GetEntityInventoryIsAttachedTo()
		return entityInventoryIsAttachedTo
	end

	function self.GetNumberOfSlots()
		return numberOfSlots
	end

	function self.GetSlots()
		return slots
	end
	----------------------------------------------------------------------------


	-- [Setup] -----------------------------------------------------------------
	function self.Setup()
		for i = 1, numberOfSlots do
			slots[i] = Slot("slot" .. i, true, "", 0)
		end
	end
	----------------------------------------------------------------------------


	-- [DropAllItems] ----------------------------------------------------------
	function self.DropAllItems()
		for i = 1, numberOfSlots do
		
			if(!slots[i].GetSlotIsEmpty()) then

				local itemFromRepo = itemsRepository.GetItem(
				slots[i].GetItemInSlot())

				slots[i].ClearSlot()

				itemFromRepo.Drop(entityInventoryIsAttachedTo)

			end

		end
	end
	----------------------------------------------------------------------------


	-- [TakeItem] --------------------------------------------------------------
	function self.TakeItem(slot, item, amount)
		for i = 1, numberOfSlots do
	
			-- Check if the item is in the specified slot and has the
			-- specified amount to remove
			if(slots[i].GetSlotName() == slot
				&& !slots[i].GetSlotIsEmpty()
				&& slots[i].GetItemInSlot() == item.GetItemIdentifier()
				&& slots[i].GetItemInSlotCount() >= amount) then
				
				-- If it does have the specified amount to remove, remove it one
				-- by one just in case (we don't want the count to go below 0)
				for j = 1, amount do
				
					slots[i].SetItemInSlotCount(slots[i].GetItemInSlotCount() 
					- 1) 
					
					
					if(slots[i].GetItemInSlotCount() == 0) then
					
						-- Once the count is 0, then set that slot to empty
						slots[i].SetSlotIsEmpty(true)
						slots[i].SetItemInSlot("")
						slots[i].SetItemInSlotCount(0)
						
						-- Return true to let the caller know the item was taken
						-- from the inventory
						return true
					
					end
				
				end
				
				-- Return true to let the caller know the item was taken
				-- from the inventory
				return true

			end
			
		end
		
		-- Return false to let the caller know the item wasn't taken
		-- from the inventory
		return false
	end
	----------------------------------------------------------------------------


	-- [AddItem] ---------------------------------------------------------------
	function self.AddItem(item, amount)
		-- If the amount to add is 0, do nothing
		if(amount == 0) then return false end
		
		-- First check if the item is stackable and already exists and
		-- if it does add it to that stack of items in the inventory
		if(item.GetItemStackable()) then

			for i = 1, numberOfSlots do
			
				if(!slots[i].GetSlotIsEmpty()) then 
				
					if(slots[i].GetItemInSlot() == item.GetItemIdentifier()) then
				
						slots[i].SetItemInSlotCount(
						slots[i].GetItemInSlotCount() + amount) 
						
						
						-- Return true to let the caller know the item was added
						-- to the inventory
						return true
							
					end
						
				end
					
			end


			-- If it is stackable but it isnt in the inventory just add that
		    -- amount to the first empty slot
			for i = 1, numberOfSlots do
			
				if(slots[i].GetSlotIsEmpty()) then 
				
					slots[i].SetSlotIsEmpty(false)
					slots[i].SetItemInSlot(item.GetItemIdentifier())
					slots[i].SetItemInSlotCount(amount)
					
					-- Return true to let the caller know the item was added
					-- to the inventory
					return true
					
					
				end

			end
			
		end
		
		-- If the above hasnt placed the item in the inventory it means it
		-- either isn't stackable or it's a different item, so find
		-- the next empty slot
		
		-- But before we do that, we need to check the amount. If it is 1, we
		-- simply add it to the next available free slot
		
		if(amount == 1) then 
		
			for i = 1, numberOfSlots do
			
				if(slots[i].GetSlotIsEmpty()) then 
				
					slots[i].SetSlotIsEmpty(false)
					slots[i].SetItemInSlot(item.GetItemIdentifier())
					slots[i].SetItemInSlotCount(amount)
					
					-- Return true to let the caller know the item was added
					-- to the inventory
					return true
					
				end
				
			end
			
		else
		
			-- If it isn't 1 we need to add it to each available slot until
			-- either the inventory is full or we have no more items to add
			
			-- THE BELOW IMPLEMENTATION ADDS ALL OF THEM TO A STACK EVEN
			-- THOUGH THE ITEMS ARENT STACKABLE. THIS MIGHT BE CHANGED
			for i = 1, numberOfSlots do
			
				if(!slots[i].GetSlotIsEmpty()) then 
				
					if(slots[i].GetItemInSlot() == item.GetItemIdentifier()) then
				
						slots[i].SetItemInSlotCount(
						slots[i].GetItemInSlotCount() + amount) 
						
						
						-- Return true to let the caller know the item was added
						-- to the inventory
						return true
							
					end
						
				end
					
			end


			for i = 1, numberOfSlots do
			
				if(slots[i].GetSlotIsEmpty()) then 
				
					slots[i].SetSlotIsEmpty(false)
					slots[i].SetItemInSlot(item.GetItemIdentifier())
					slots[i].SetItemInSlotCount(amount)
					
					-- Return true to let the caller know the item was added
					-- to the inventory
					return true
					
					
				end

			end
			
		
		end
		
		return false
	end
	----------------------------------------------------------------------------


	return self

end
--------------------------------------------------------------------------------