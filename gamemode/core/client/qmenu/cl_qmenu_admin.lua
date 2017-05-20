--------------------------------------------------------------------------------
-- [Draw Admin]
--------------------------------------------------------------------------------
adminButtonsInfo = {}

-- Setup a local table for the admin buttons
adminButtonsInfo[1] = {identifier = "kick", text = "Kick", 
						colour = Color(245, 185, 65),
						image = "icon16/error.png",
						func = function(plyName)
							Derma_StringRequest(
								
								"Kick",
								
								"Are you sure you want to kick " ..
								plyName .. "?",
								
								"",
								
								function(reason)
									LocalPlayer():ConCommand("tcsg_kick \"" .. 
									plyName .. "\" " .. reason)
								end,
								
								function(reason) return end
								
							)
						end}
						
adminButtonsInfo[2] = {identifier = "ban", text = "Ban", 
						colour = Color(245, 125, 65),
						image = "icon16/exclamation.png",
						func = function()
							print("Ban")
						end}
						
						

-- Now that we have the those setup, we are going to loop through a local table
-- conCommandsToAdd so that for each of the networked variables (such as tokens
-- victories etc we create an Add, Set and Subtract button. This saves us from
-- doing it manually
local x = 3
local conCommandsToAdd = {"victories", "tokens", "kills", "deaths"}

-- Add Buttons
for k, v in pairs(conCommandsToAdd) do

	-- Create button with icon, the function just checks if the argument is a 
	-- number and calls a local concommand which in turn does a server side 
	-- check to see if the user can actually execute that command
	adminButtonsInfo[x] = {identifier = "add" .. v, text = "Add " .. v, 
							colour = Color(165, 200, 90),
							image = "icon16/add.png",
							
							func = function(plyName)
								Derma_StringRequest(
								
									"Add",
									
									"Enter an amount to add to " ..
									plyName .. "'s " .. v .. ":",
									
									"",
									
									function(amount)
										amount = tonumber(amount)
										if(type(amount) != "number") then return end
										LocalPlayer():ConCommand("tcsg_" .. 
										v .. "_add \"" .. 
										plyName .. "\" " .. amount)
									end,
									
									function(amount) return end
									
								)
							end}
						
	x = x + 1

end

-- Subtract Buttons
for k, v in pairs(conCommandsToAdd) do

	-- Create button with icon, the function just checks if the argument is a 
	-- number and calls a local concommand which in turn does a server side 
	-- check to see if the user can actually execute that command
	adminButtonsInfo[x] = {identifier = "subtract" .. v, text = "Subtract " .. v,
							colour = Color(90, 200, 165),
							image = "icon16/delete.png",
							
							func = function(plyName)
								Derma_StringRequest(
								
									"Subtract",
									
									"Enter an amount to subtract from " ..
									plyName .. "'s " .. v .. ":",
									
									"",
									
									function(amount)
										amount = tonumber(amount)
										if(type(amount) != "number") then return end
										LocalPlayer():ConCommand("tcsg_" .. 
										v .. "_subtract \"" .. 
										plyName .. "\" " .. amount)
									end,
									
									function(amount) return end
									
								)
							end}
						
	x = x + 1

end

-- Set Buttons
for k, v in pairs(conCommandsToAdd) do

	-- Create button with icon, the function just checks if the argument is a 
	-- number and calls a local concommand which in turn does a server side 
	-- check to see if the user can actually execute that command
	adminButtonsInfo[x] = {identifier = "set" .. v, text = "Set " .. v,
							colour = Color(115, 170, 230),
							image = "icon16/pencil.png",
							
							func = function(plyName)
								Derma_StringRequest(
									"Set",
									
									"Enter an amount to set " ..
									plyName .. "'s " .. v .. " to:",
									
									"",
									
									function(amount)
										amount = tonumber(amount)
										if(type(amount) != "number") then return end
										LocalPlayer():ConCommand("tcsg_" .. 
										v .. "_set \"" .. 
										plyName .. "\" " .. amount)
									end,
									
									function(amount) return end
									
								)
							end}
						
	x = x + 1

end
--------------------------------------------------------------------------------
function DrawAdmin()

	-- If the player isn't admin, don't draw the Admin tab
	if(LocalPlayer():IsAdmin()) then
	
		-- Create base panel
		local adminBasePanel = vgui.Create("DPanel")
		adminBasePanel:SetPos(0, 0)
		adminBasePanel:SetBackgroundColor(Color(255, 255, 255, 0))
		adminBasePanel:SetSize(basePropertySheet:GetWide(), 
		basePropertySheet:GetTall() - 32)
		
		-- Add admin tab to property sheet
		basePropertySheet:AddSheet("[   TCSG Admin   ]", adminBasePanel, 
									"icon16/user_gray.png", false, false, 
									"TCSG Gamemode Admin Menu")
	
		
		-- Create a list of players
		local horizontalScroller = vgui.Create("DHorizontalScroller", adminBasePanel)
		horizontalScroller:SetPos(0, 0)
		horizontalScroller:SetSize(adminBasePanel:GetWide() - 256, 
		adminBasePanel:GetTall())
		
		-- Create a list of players
		local playerList = vgui.Create("DListView", horizontalScroller)
		playerList:SetPos(0, 0)
		playerList:SetSize(adminBasePanel:GetWide() - 256, 
		adminBasePanel:GetTall())
		
		playerList:SetMultiSelect(false)
		playerList:AddColumn("Steam ID")
		playerList:AddColumn("Username")
		playerList:AddColumn("Team")
		
		-- For the local table add a column for each networked variable
		-- (just like we did for the buttons).
		for k, v in pairs(conCommandsToAdd) do
			playerList:AddColumn(v)
		end
		
		-- For each player, populate the list view with the relevant information
		for k, v in pairs(player.GetAll()) do
			playerList:AddLine(v:SteamID(), v:GetName(), team.GetName(v:Team()), 
								v:GetNWInt("victories"),
								v:GetNWInt("tokens"),
								v:GetNWInt("kills"),
								v:GetNWInt("deaths"))
		end
		
		-- Panel on the right to hold the buttons
		local panelForButtons = vgui.Create("DPanel", adminBasePanel)
		panelForButtons:SetPos(adminBasePanel:GetWide() - 256, 0)
		panelForButtons:SetBackgroundColor(Color(255, 255, 255, 255))
		panelForButtons:SetSize(256, 
		adminBasePanel:GetTall())
		
		-- Scroll panel to scroll down as there could potentially be
		-- many buttons
		local buttonsScrollPanel = vgui.Create("DScrollPanel", panelForButtons)
		buttonsScrollPanel:SetPos(0, 0)
		buttonsScrollPanel:SetSize(panelForButtons:GetWide(), 
		panelForButtons:GetTall() - 12)
		
		-- A list layout so we can easily add buttons to it
		local buttonsListLayout = vgui.Create( "DListLayout", buttonsScrollPanel )
		buttonsListLayout:SetPos(0, 0)
		buttonsListLayout:SetSize(buttonsScrollPanel:GetWide(), buttonsScrollPanel:GetTall())
		
		-- Loop through the table we made earlier on so we can
		-- construct the buttons
		for k, button in pairs(adminButtonsInfo) do
		
			adminButton = vgui.Create("DButton")
			adminButton:SetPos(0, 0)
			adminButton:SetSize(64, 40)
			adminButton:SetFont("QMenuMedium")
			adminButton:SetText(button.text)
			adminButton:SetDark(1)
			
			--Paint over the button to give it a colour
			adminButton.Paint = function()
			
				surface.SetDrawColor(button.colour)
				surface.DrawRect(0, 0, adminButton:GetWide(), 
				adminButton:GetTall())
				
				surface.SetDrawColor(0, 0, 0, 255)
				surface.DrawOutlinedRect(0, 0, adminButton:GetWide(), 
				adminButton:GetTall())
				
			end
			
			-- Set the image of the button (small icon16 aligned to the left)
			adminButton:SetImage(button.image)
			
			-- When clicking the button, get the relevant line and execute
			-- the function specified in the adminsButtonsInfo table
			adminButton.DoClick = function()
				if(!playerList:GetSelectedLine()) then 
					Derma_Message("No player selected", "Error", "Ok") 
				else
					button.func(playerList:GetLines()
					[playerList:GetSelectedLine()]:GetValue(2))
				end
			end
			
			-- Add some margins so the buttons aren't attached to eachother
			-- DockMargin parameters are as follows (left, top, right, bottom)
			adminButton:DockMargin(10, 10, 30, 10)
			
			-- Lastly, add the button to the list of buttons
			buttonsListLayout:Add(adminButton)
			
		end
		
	end

end
--------------------------------------------------------------------------------