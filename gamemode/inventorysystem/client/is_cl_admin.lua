--------------------------------------------------------------------------------
-- [Draw Admin]
--------------------------------------------------------------------------------
ISAdminButtons = {}

-- Setup a local table for the admin buttons
ISAdminButtons[1] = {identifier = "give1", text = "Give 1", 
						colour = Color(65, 180, 245),
						image = "icon16/add.png",
						func = function(plyName, itemName)
							
							LocalPlayer():ConCommand("is_item_give" ..
							"\"" .. plyName .. "\" " .. itemName .. 
							" 1")

						end}

ISAdminButtons[2] = {identifier = "give5", text = "Give 5", 
						colour = Color(80, 175, 220),
						image = "icon16/add.png",
						func = function(plyName, itemName)
							
							LocalPlayer():ConCommand("is_item_give" ..
							"\"" .. plyName .. "\" " .. itemName .. 
							" 5")

						end}

ISAdminButtons[3] = {identifier = "giveX", text = "Give X Amount", 
						colour = Color(100, 160, 200),
						image = "icon16/add.png",
						func = function(plyName, itemName)
							
							Derma_StringRequest(
								
								"Give X Amount",
								
								"Enter the amount of " .. itemName ..
								" to give to " .. plyName,
								
								"",
								
								function(amount)
									amount = tonumber(amount)
									if(type(amount) != "number") then return end
									LocalPlayer():ConCommand("is_item_give" ..
									"\"" .. plyName .. "\" " .. itemName .. 
									" " .. amount)
								end,
								
								function(amount) return end
								
							)

						end}												
--------------------------------------------------------------------------------
function DrawISAdmin()

	-- If the player isn't admin, don't draw the Admin tab
	if(LocalPlayer():IsAdmin()) then
	
		-- Create base panel
		local ISAdminBasePanel = vgui.Create("DPanel")
		ISAdminBasePanel:SetPos(0, 0)
		ISAdminBasePanel:SetBackgroundColor(Color(255, 255, 255, 0))
		ISAdminBasePanel:SetSize(basePropertySheet:GetWide(), 
		basePropertySheet:GetTall() - 32)
		
		-- Add admin tab to property sheet
		basePropertySheet:AddSheet("[   IS Admin   ]", ISAdminBasePanel, 
									"icon16/user_gray.png", false, false, 
									"Inventory System Admin Menu")
		
		
		-- Create a list of players
		local ISPlayerList = vgui.Create("DListView", ISAdminBasePanel)
		ISPlayerList:SetPos(0, 0)
		ISPlayerList:SetSize(ISAdminBasePanel:GetWide() - 256, 
		ISAdminBasePanel:GetTall()/2)
		
		ISPlayerList:SetMultiSelect(false)
		ISPlayerList:AddColumn("Steam ID")
		ISPlayerList:AddColumn("Username")
		
		-- For each player, populate the list view with the relevant information
		for k, v in pairs(player.GetAll()) do
			ISPlayerList:AddLine(v:SteamID(), v:GetName())
		end



		-- Create a list of items
		local ISItemList = vgui.Create("DListView", ISAdminBasePanel)
		ISItemList:SetPos(0, ISAdminBasePanel:GetTall()/2)
		ISItemList:SetSize(ISAdminBasePanel:GetWide() - 256, 
		ISAdminBasePanel:GetTall()/2)
		
		ISItemList:SetMultiSelect(false)
		ISItemList:AddColumn("Item Identifier")
		ISItemList:AddColumn("Item Category")
		ISItemList:AddColumn("Item Tier")
		ISItemList:AddColumn("Item Name")
		
		items = itemsRepository.GetAllItems()
		-- For each player, populate the list view with the relevant information
		for k, item in pairs(items) do
			ISItemList:AddLine(item.GetItemIdentifier(), 
			item.GetItemCategory(), item.GetItemTier(),
			item.GetItemName())
		end


		
		-- Panel on the right to hold the buttons
		local ISPanelForButtons = vgui.Create("DPanel", ISAdminBasePanel)
		ISPanelForButtons:SetPos(ISAdminBasePanel:GetWide() - 256, 0)
		ISPanelForButtons:SetBackgroundColor(Color(255, 255, 255, 255))
		ISPanelForButtons:SetSize(256, 
		ISAdminBasePanel:GetTall())
		
		-- Scroll panel to scroll down as there could potentially be
		-- many buttons
		local ISButtonsScrollPanel = vgui.Create("DScrollPanel", ISPanelForButtons)
		ISButtonsScrollPanel:SetPos(0, 0)
		ISButtonsScrollPanel:SetSize(ISPanelForButtons:GetWide(), 
		ISPanelForButtons:GetTall() - 12)
		
		-- A list layout so we can easily add buttons to it
		local ISButtonsListLayout = vgui.Create( "DListLayout", ISButtonsScrollPanel )
		ISButtonsListLayout:SetPos(0, 0)
		ISButtonsListLayout:SetSize(ISButtonsScrollPanel:GetWide(), ISButtonsScrollPanel:GetTall())
		
		-- Loop through the table we made earlier on so we can
		-- construct the buttons
		for k, button in pairs(ISAdminButtons) do
		
			local ISAdminButton = vgui.Create("DButton")
			ISAdminButton:SetPos(0, 0)
			ISAdminButton:SetSize(64, 40)
			ISAdminButton:SetFont("QMenuMedium")
			ISAdminButton:SetText(button.text)
			ISAdminButton:SetDark(1)
			
			--Paint over the button to give it a colour
			ISAdminButton.Paint = function()
			
				surface.SetDrawColor(button.colour)
				surface.DrawRect(0, 0, ISAdminButton:GetWide(), 
				ISAdminButton:GetTall())
				
				surface.SetDrawColor(0, 0, 0, 255)
				surface.DrawOutlinedRect(0, 0, ISAdminButton:GetWide(), 
				ISAdminButton:GetTall())
				
			end
			
			-- Set the image of the button (small icon16 aligned to the left)
			ISAdminButton:SetImage(button.image)
			
			-- When clicking the button, get the relevant line and execute
			-- the function specified in the adminsButtonsInfo table
			ISAdminButton.DoClick = function()
				if(!ISPlayerList:GetSelectedLine()) then 
					Derma_Message("No player selected", "Error", "Ok") 
				else
					if(!ISItemList:GetSelectedLine()) then 
						Derma_Message("No item selected", "Error", "Ok") 
					else
						button.func(ISPlayerList:GetLines()
						[ISPlayerList:GetSelectedLine()]:GetValue(2),
						ISItemList:GetLines()
						[ISItemList:GetSelectedLine()]:GetValue(1))
					end
				end
			end
			
			-- Add some margins so the buttons aren't attached to eachother
			-- DockMargin parameters are as follows (left, top, right, bottom)
			ISAdminButton:DockMargin(10, 10, 30, 10)
			
			-- Lastly, add the button to the list of buttons
			ISButtonsListLayout:Add(ISAdminButton)
			
		end
		
	end

end
--------------------------------------------------------------------------------