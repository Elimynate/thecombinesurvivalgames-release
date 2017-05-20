--------------------------------------------------------------------------------
-- [Draw Inventory]
--------------------------------------------------------------------------------
local inventory = {}
inventory.slots = 0
inventory.slot = {}
--------------------------------------------------------------------------------
function DrawInventory()
	
	-- Communicate an inventory update request to the server so the correct
	-- inventory can be drawn
	net.Start("ClientRequestInventoryUpdate")
	net.SendToServer()

	local ISInventoryBasePanel = vgui.Create("DPanel")
	ISInventoryBasePanel:SetPos(0, 0)
	ISInventoryBasePanel:SetBackgroundColor(Color(255, 255, 255, 0))
	
	ISInventoryBasePanel:SetSize(basePropertySheet:GetWide(), 
	basePropertySheet:GetTall())
	
	basePropertySheet:AddSheet("[  Inventory   ]", ISInventoryBasePanel, 
								"icon16/briefcase.png", false, false, 
								"Your Inventory")
	
	
	-- Upon receival of the correct information do the following
	net.Receive("ClientReceiveInventoryUpdate", function()

		if(ISInventoryBasePanel == nil) then return end

		ISInventoryBasePanel:Clear()
		------------------------------------------------------------------------
		-- Setup a PanelSelect as the inventory grid
		local ISInventoryGrid	= vgui.Create("DPanelSelect", ISInventoryBasePanel)
		
		ISInventoryGrid:SetSize(
		ISInventoryBasePanel:GetWide()/2, 
		ISInventoryBasePanel:GetTall())
		
		ISInventoryGrid:SetPos(0, 0)
		
		------------------------------------------------------------------------
		-- Setup a panel to the right of the inventory to display item
		-- information
		local ISInventoryItemInfoPanel = vgui.Create("DPanel", 
		ISInventoryBasePanel)
		
		ISInventoryItemInfoPanel:SetPos(ISInventoryBasePanel:GetWide()/2, 0)
		
		ISInventoryItemInfoPanel:SetSize(
		ISInventoryBasePanel:GetWide()/2, 
		ISInventoryBasePanel:GetTall())
		
		ISInventoryItemInfoPanel:SetBackgroundColor(
		Color(255, 255, 255, 125))
		
		------------------------------------------------------------------------
		-- Setup a scroll panel for the ListLayout we will add below this
		local ISInventoryItemInfoScrollPanel = vgui.Create("DScrollPanel", 
		ISInventoryItemInfoPanel)
		
		ISInventoryItemInfoScrollPanel:SetPos(0, 0)
		
		ISInventoryItemInfoScrollPanel:SetSize(ISInventoryItemInfoPanel:GetWide(), 
		ISInventoryItemInfoPanel:GetTall())
		
		------------------------------------------------------------------------
		-- For that panel setup a list so that we can add item specific
		-- information (such as buttons, labels, ModelPanels etc)
		local ISInventoryItemInfoListLayout	= vgui.Create("DListLayout", 
		ISInventoryItemInfoScrollPanel)
		
		ISInventoryItemInfoListLayout:SetPos(0, 0)
		
		ISInventoryItemInfoListLayout:SetSize(
		ISInventoryItemInfoScrollPanel:GetWide(), 
		ISInventoryItemInfoScrollPanel:GetTall())
	
		------------------------------------------------------------------------
		-- Localise the various variables (which slots are taken, what item
		-- is in that slot etc)
		inventory.slots = net.ReadInt(16)
		
		for i = 1, inventory.slots do
		
			inventory.slot[i] = 
			{
				slotName = net.ReadString(),
				isEmpty = net.ReadBool(),
				item = net.ReadString(),
				count = net.ReadInt(16)
			}
		
			-- Then for each slot populate it as needed
			local ISSlot = vgui.Create("DPanel")
			ISSlot:SetSize(ISInventoryGrid:GetWide()/5 - 12, 
			ISInventoryGrid:GetWide()/5 - 8)
			
			local label = vgui.Create("DLabel", ISSlot)
			label:SetPos(4, 4)
			label:SetDark(1)
			label:SetFont("InventorySmall")
			
			if(inventory.slot[i].isEmpty) then
			
				-- If the slot is empty, give it a background color
				-- and do nothing
				ISSlot:SetBackgroundColor(Color(150, 150, 150, 255))
				label:SetText("")
				
			else
				
				local itemFromRepo = itemsRepository.GetItem(inventory.slot[i].item)
				
				-- Otherwise if it isn't empty, get the correct model
				-- for that item and display it in the inventory
				local model = vgui.Create("DModelPanel", ISSlot)
				model:SetSize(ISSlot:GetWide(), ISSlot:GetWide())
				model:SetModel(itemFromRepo.GetItemModel())
				function model:LayoutEntity(Entity)
					Entity:SetSkin(itemFromRepo.GetItemSkin())
				end
				model:SetCamPos(Vector(32, 32, 32))
				model:SetLookAt(Vector(0, 0, 0))
				model:SetFOV(itemFromRepo.GetItemModelDist())
				
				
				-- If the item is stackable display the amount in the slot
				if(itemFromRepo.GetItemStackable()) then
					label:SetText(itemFromRepo.GetItemName() ..
						"\n(" .. inventory.slot[i].count .. ")")
				-- Otherwise just display the name of the item
				else
					label:SetText(itemFromRepo.GetItemName())
				end
				
				
				-- When clicking on an item with the left mouse button
				model.DoClick = function()
					------------------------------------------------------------
					-- Clear each time a new item is pressed in inventory
					ISInventoryItemInfoListLayout:Clear()
					-------------------------------
					-- Display the name of the item
					local selectedItemLabelName = vgui.Create("DLabel")
					
					selectedItemLabelName:DockMargin(10, 10, 10, 10)
					
					selectedItemLabelName:SetContentAlignment(5)
					
					selectedItemLabelName:SetText(itemFromRepo.GetItemName())
					
					selectedItemLabelName:SetFont("InventoryLarge")
					
					selectedItemLabelName:SetDark(1)
					
					selectedItemLabelName:SizeToContents()
					
					-- Add the label to the list
					ISInventoryItemInfoListLayout:Add(selectedItemLabelName)
					
					-------------------------------
					-- Display the model of the item
					local selectedItemBGPanel = vgui.Create("DPanel")
					
					
					selectedItemBGPanel:SetSize(
					ISInventoryItemInfoPanel:GetWide()/3,
					ISInventoryItemInfoPanel:GetWide()/3)
					
					selectedItemBGPanel:DockMargin(10, 10, 10, 10)
					
					
					
					local selectedItemModelPanel = vgui.Create("DModelPanel",
					selectedItemBGPanel)
					
					selectedItemModelPanel:SetPos(
					selectedItemBGPanel:GetWide()/3 - 16, 0)
					
					selectedItemModelPanel:SetSize(
					selectedItemBGPanel:GetWide(), 
					selectedItemBGPanel:GetWide())
					
					selectedItemModelPanel:SetModel(itemFromRepo.GetItemModel())
					
					function selectedItemModelPanel:LayoutEntity(Entity)
						Entity:SetSkin(itemFromRepo.GetItemSkin())
					end
					
					selectedItemModelPanel:SetCamPos(Vector(32, 32, 32))
					
					selectedItemModelPanel:SetLookAt(Vector(0, 0, 0))
					
					selectedItemModelPanel:SetFOV(
					itemFromRepo.GetItemModelDist()/1.5)
					
					-- Add the BG panel with the model panel as child 
					-- to the list
					ISInventoryItemInfoListLayout:Add(selectedItemBGPanel)
					
					-------------------------------
					-- Display the description of the item
					local selectedItemDescription = vgui.Create("DLabel")
					
					selectedItemDescription:SetSize(
					ISInventoryItemInfoListLayout:GetWide(), 48)
					
					selectedItemDescription:DockMargin(10, 10, 10, 10)
					selectedItemDescription:SetText(itemFromRepo.GetItemDesc())
					selectedItemDescription:SetFont("InventoryMedium")
					selectedItemDescription:SetWrap(true)
					selectedItemDescription:SetDark(true)
					
					-- Add the label to the list
					ISInventoryItemInfoListLayout:Add(selectedItemDescription)
					
					-------------------------------
					-- Display the use button if its useable
					if(itemFromRepo.GetItemUseable()) 
					then
						
						local selectedItemUseButton = vgui.Create("DButton")
					

						selectedItemUseButton:SetSize(
						ISInventoryItemInfoPanel:GetWide()/2, 32)
						
						selectedItemUseButton:DockMargin(
						ISInventoryItemInfoPanel:GetWide()/4,
						10, 
						ISInventoryItemInfoPanel:GetWide()/4,
						10)
						
						selectedItemUseButton:SetContentAlignment(5)
						
						selectedItemUseButton:SetFont("InventoryMedium")
						
						selectedItemUseButton:SetText("Use")
						
						selectedItemUseButton:SetImage("icon16/wrench_orange.png")
						
						selectedItemUseButton:SetDark(1)
						
						selectedItemUseButton.DoClick = function()
						
							itemFromRepo.UseRequest(
								inventory.slot[i].slotName,
								inventory.slot[i].item
							)
							
							-- After the command, "refresh" the Derma screen
							-- to reflect changes
							if(ISConfig.PlayUseItemSound) then
								surface.PlaySound(ISConfig.UseItemSound)
							end
							net.Start("ClientRequestInventoryUpdate")
							net.SendToServer()
						
						end
						
						-- Add the use button to the list
						ISInventoryItemInfoListLayout:Add(selectedItemUseButton)
						
					end
					-------------------------------
					-- Display the drop button if its useable
					if(itemFromRepo.GetItemDroppable()) 
					then
						
						local selectedItemDropButton = vgui.Create("DButton")

					
						selectedItemDropButton:SetSize(
						ISInventoryItemInfoPanel:GetWide()/2, 32)
						
						selectedItemDropButton:DockMargin(
						ISInventoryItemInfoPanel:GetWide()/4,
						10, 
						ISInventoryItemInfoPanel:GetWide()/4,
						10)
						
						selectedItemDropButton:SetContentAlignment(5)
						
						selectedItemDropButton:SetFont("InventoryMedium")
						
						selectedItemDropButton:SetText("Drop")
						
						selectedItemDropButton:SetImage("icon16/bullet_arrow_bottom.png")
						
						selectedItemDropButton:SetDark(1)
						
						selectedItemDropButton.DoClick = function()
						
							itemFromRepo.DropRequest(
								inventory.slot[i].slotName,
								inventory.slot[i].item
							)
							
							-- After the command, "refresh" the Derma screen
							-- to reflect changes
							if(ISConfig.PlayDropItemSound) then
								surface.PlaySound(ISConfig.DropItemSound)
							end
							net.Start("ClientRequestInventoryUpdate")
							net.SendToServer()
						
						end
						
						-- Add the use button to the list
						ISInventoryItemInfoListLayout:Add(selectedItemDropButton)
						
					end
					-------------------------------
					------------------------------------------------------------
				end
				-- When clicking on an item with the right mouse button
				model.DoRightClick = function()
					------------------------------------------------------------
					-- Derma menu to allow for the execution of the options
					-- for an item
					-- as overridden (or not) for each item
					local optionsMenuForItem = DermaMenu()
					
					
					--[IsUseable]-----------------------------------------------
					if(itemFromRepo.GetItemUseable()) 
					then
					
						optionsMenuForItem:AddOption("Use", function()
							
							itemFromRepo.UseRequest(
								inventory.slot[i].slotName,
								inventory.slot[i].item
							)
							
							-- After the command, "refresh" the Derma screen
							-- to reflect changes
							if(ISConfig.PlayUseItemSound) then
								surface.PlaySound(ISConfig.UseItemSound)
							end
							net.Start("ClientRequestInventoryUpdate")
							net.SendToServer()
							
						end):SetImage("icon16/wrench_orange.png")
						
					end
					------------------------------------------------------------
					
					
					--[IsDroppable]---------------------------------------------
					if(itemFromRepo.GetItemDroppable()) 
					then
					
						optionsMenuForItem:AddOption("Drop", function()
							
							itemFromRepo.DropRequest(
								inventory.slot[i].slotName,
								inventory.slot[i].item
							)
							
							-- After the command, "refresh" the Derma screen
							-- to reflect changes
							if(ISConfig.PlayDropItemSound) then
								surface.PlaySound(ISConfig.DropItemSound)
							end
							net.Start("ClientRequestInventoryUpdate")
							net.SendToServer()
							
						end):SetImage("icon16/bullet_arrow_bottom.png")
						
					end
					------------------------------------------------------------
					
					-- Open the menu constructed above
					optionsMenuForItem:Open()
					------------------------------------------------------------
				end
				
			end
			
			-- Set the label displaying the item name (and count if its 
			-- stackable) to the correct size
			label:SizeToContents()
			
			-- Lastly, add the slot to the ISInventoryGrid
			ISInventoryGrid:AddItem(ISSlot)
			
		end
		
	end)
	
end
--------------------------------------------------------------------------------