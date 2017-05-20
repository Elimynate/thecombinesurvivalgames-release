--------------------------------------------------------------------------------
-- [ItemsRepository Object]
--------------------------------------------------------------------------------
function ItemsRepository()

	local self = {}


	-- [Private Class Variables] -----------------------------------------------
	local itemsCount = 0
	local items = {}
	local itemsIndexed = {}

	local itemsCategorisedCount = {}
	local itemsCategorised = {}
	local itemsCategorisedIndexed = {}

	local itemsTieredCount = {}
	local itemsTiered = {}
	local itemsTieredIndexed = {}
	----------------------------------------------------------------------------


	-- [AddItem] ---------------------------------------------------------------
	function self.AddItem(item)

		itemsCount = itemsCount + 1

		-- Table of all items
		items[item.GetItemIdentifier()] = item

		-- Table of item identifiers mapped to a number
		itemsIndexed[itemsCount] = item:GetItemIdentifier()

		------------------------------------------------------------------------

		-- Table of tables, where each table contains category specific
		-- items only
		if(!itemsCategorised[item.GetItemCategory()]) then
			itemsCategorised[item.GetItemCategory()] = {}
			itemsCategorisedCount[item.GetItemCategory()] = 0
		end

		itemsCategorised[item.GetItemCategory()]
		[item.GetItemIdentifier()] = item

		itemsCategorisedCount[item.GetItemCategory()] = 
		itemsCategorisedCount[item.GetItemCategory()] + 1

		-- Table of tables, where each table contains category specific
		-- items mapped to numbers only
		if(!itemsCategorisedIndexed[item.GetItemCategory()]) then
			itemsCategorisedIndexed[item.GetItemCategory()] = {}
		end

		itemsCategorisedIndexed[item.GetItemCategory()]
		[itemsCategorisedCount[item.GetItemCategory()]] = 
		item:GetItemIdentifier()

		------------------------------------------------------------------------

		-- Table of tables, where each table contains tier specific
		-- items only
		if(!itemsTiered[item.GetItemTier()]) then
			itemsTiered[item.GetItemTier()] = {}
			itemsTieredCount[item.GetItemTier()] = 0
		end

		itemsTiered[item.GetItemTier()]
		[item.GetItemIdentifier()] = item

		itemsTieredCount[item.GetItemTier()] = 
		itemsTieredCount[item.GetItemTier()] + 1

		-- Table of tables, where each table contains tier specific
		-- items mapped to numbers only
		if(!itemsTieredIndexed[item.GetItemTier()]) then
			itemsTieredIndexed[item.GetItemTier()] = {}
		end

		itemsTieredIndexed[item.GetItemTier()]
		[itemsTieredCount[item.GetItemTier()]] = 
		item:GetItemIdentifier()

		------------------------------------------------------------------------

	end
	----------------------------------------------------------------------------

	
	-- [ContainsItem] ----------------------------------------------------------
	function self.ContainsItem(arg)
		return items[arg] ~= nil
	end
	----------------------------------------------------------------------------
	
	
	-- [Getters] ---------------------------------------------------------------
	function self.GetItem(arg)
		return items[arg]
	end
	
	function self.GetAllItems()
		return items
	end
	
	function self.GetAnyRandomItem()
		math.randomseed(os.time())
		return items[itemsIndexed[math.random(1, #itemsIndexed)]]
	end

	function self.GetRandomItemFromCategory(category)
		math.randomseed(os.time())
		return items[itemsCategorisedIndexed[category]
		[math.random(1, #itemsCategorisedIndexed[category])]]
	end

	function self.GetRandomItemFromTier(tier)
		math.randomseed(os.time())
		return items[itemsTieredIndexed[tier]
		[math.random(1, #itemsTieredIndexed[tier])]]
	end
	----------------------------------------------------------------------------


	return self

end
--------------------------------------------------------------------------------
itemsRepository = ItemsRepository()
--------------------------------------------------------------------------------