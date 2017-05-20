--------------------------------------------------------------------------------
-- [Item Object]
--------------------------------------------------------------------------------
function Item(itemType, itemIdentifier, itemCategory, itemTier, itemName, 
	itemDesc, itemModel, itemSkin, droppable, useable, stackable, 
	modelDistInSlot)

	local self = {}


	-- [Private Class Variables] -----------------------------------------------
	local itemType = itemType
	local itemIdentifier = itemIdentifier
	local itemCategory = itemCategory
	local itemTier = itemTier
	local itemName = itemName
	local itemDesc = itemDesc
	local itemModel = itemModel
	local itemSkin = itemSkin
	local droppable = droppable
	local useable = useable
	local stackable = stackable
	local modelDistInSlot = modelDistInSlot
	----------------------------------------------------------------------------


	-- [Getters] ---------------------------------------------------------------
	function self.GetItemType()
		return itemType
	end

	function self.GetItemIdentifier()
		return itemIdentifier
	end

	function self.GetItemCategory()
		return itemCategory
	end

	function self.GetItemTier()
		return itemTier
	end

	function self.GetItemName()
		return itemName
	end

	function self.GetItemDesc()
		return itemDesc
	end

	function self.GetItemModel()
		return itemModel
	end

	function self.GetItemSkin()
		return itemSkin
	end

	function self.GetItemDroppable()
		return droppable
	end

	function self.GetItemUseable()
		return useable
	end

	function self.GetItemStackable()
		return stackable
	end

	function self.GetItemModelDist()
		return modelDistInSlot
	end
	----------------------------------------------------------------------------


	-- [DropRequest] -----------------------------------------------------------
	function self.DropRequest(slot)
	
		net.Start("ClientRequestDropItem")
			net.WriteString(slot)
			net.WriteString(itemIdentifier)
		net.SendToServer()
	
	end
	----------------------------------------------------------------------------


	-- [UseRequest] ------------------------------------------------------------
	function self.UseRequest(slot)
	
		net.Start("ClientRequestUseItem")
			net.WriteString(slot)
			net.WriteString(itemIdentifier)
		net.SendToServer()
	
	end
	----------------------------------------------------------------------------


	-- [Drop] ------------------------------------------------------------------
	function self.Drop(ply)
	
		-- Can be overridden for individual items (by default it will drop
		-- the item in the world in front of the player)
		
		DropItemInWorld(self,
		ply:GetPos() + 40*ply:GetForward() + Vector(0, 0, 35))
	
	end
	----------------------------------------------------------------------------


	-- [Use] -------------------------------------------------------------------
	function self.Use(ply)
	
		-- Override this to implement the actual functionality on item usage
		-- (override for individual Item objects, don't do it in here)
	
	end
	----------------------------------------------------------------------------


	-- [Use] -------------------------------------------------------------------
	function self.AlreadyUsed(ply)
	
		-- Override this to implement the actual functionality when
		-- checking if an about to be used item has already been used
		return false
	
	end
	----------------------------------------------------------------------------


	-- [Use] -------------------------------------------------------------------
	function self.UseAndAlreadyUsed(ply)
	
		-- Override this to implement the actual functionality when
		-- an item of the same type is already used
		-- for example if you have a pistol, by using (equipping)
		-- another pistol you will get ammo instead of nothing happening
	
	end
	----------------------------------------------------------------------------


	return self

end
--------------------------------------------------------------------------------