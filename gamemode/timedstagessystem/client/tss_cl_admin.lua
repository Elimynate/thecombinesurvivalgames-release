--------------------------------------------------------------------------------
-- [Draw Admin]
--------------------------------------------------------------------------------
TSSAdminButtons = {}

-- Setup a local table for the admin buttons
TSSAdminButtons[1] = {identifier = "nextstage", text = "Next Stage", 
						colour = Color(245, 215, 85),
						image = "icon16/bullet_go.png",
						func = function()
							
							LocalPlayer():ConCommand("tss_stage_next")

						end}											
--------------------------------------------------------------------------------
function DrawTSSAdmin()

	-- If the player isn't admin, don't draw the Admin tab
	if(LocalPlayer():IsAdmin()) then
	
		-- Create base panel
		local TSSAdminBasePanel = vgui.Create("DPanel")
		TSSAdminBasePanel:SetPos(0, 0)
		TSSAdminBasePanel:SetBackgroundColor(Color(255, 255, 255, 0))
		TSSAdminBasePanel:SetSize(basePropertySheet:GetWide(), 
		basePropertySheet:GetTall() - 32)
		
		-- Add admin tab to property sheet
		basePropertySheet:AddSheet("[   TSS Admin   ]", TSSAdminBasePanel, 
									"icon16/user_gray.png", false, false, 
									"Timed Stages System Admin Menu")
		
		




		-- Create a list of stages
		local TSSStagesList = vgui.Create("DListView", TSSAdminBasePanel)
		TSSStagesList:SetPos(0, 0)
		TSSStagesList:SetSize(TSSAdminBasePanel:GetWide() - 256, 
		TSSAdminBasePanel:GetTall())
		
		TSSStagesList:SetMultiSelect(false)
		TSSStagesList:AddColumn("Stage Number")
		TSSStagesList:AddColumn("Stage Name")
		TSSStagesList:AddColumn("Stage Length")
		


		
		-- Panel on the right to hold the buttons
		local TSSPanelForButtons = vgui.Create("DPanel", TSSAdminBasePanel)
		TSSPanelForButtons:SetPos(TSSAdminBasePanel:GetWide() - 256, 0)
		TSSPanelForButtons:SetBackgroundColor(Color(255, 255, 255, 255))
		TSSPanelForButtons:SetSize(256, 
		TSSAdminBasePanel:GetTall())
		
		-- Scroll panel to scroll down as there could potentially be
		-- many buttons
		local TSSButtonsScrollPanel = vgui.Create("DScrollPanel", TSSPanelForButtons)
		TSSButtonsScrollPanel:SetPos(0, 0)
		TSSButtonsScrollPanel:SetSize(TSSPanelForButtons:GetWide(), 
		TSSPanelForButtons:GetTall() - 12)
		
		-- A list layout so we can easily add buttons to it
		local TSSButtonsListLayout = vgui.Create( "DListLayout", TSSButtonsScrollPanel )
		TSSButtonsListLayout:SetPos(0, 0)
		TSSButtonsListLayout:SetSize(TSSButtonsScrollPanel:GetWide(), TSSButtonsScrollPanel:GetTall())
		
		-- Loop through the table we made earlier on so we can
		-- construct the buttons
		for k, button in pairs(TSSAdminButtons) do
		
			local TSSAdminButton = vgui.Create("DButton")
			TSSAdminButton:SetPos(0, 0)
			TSSAdminButton:SetSize(64, 40)
			TSSAdminButton:SetFont("QMenuMedium")
			TSSAdminButton:SetText(button.text)
			TSSAdminButton:SetDark(1)
			
			--Paint over the button to give it a colour
			TSSAdminButton.Paint = function()
			
				surface.SetDrawColor(button.colour)
				surface.DrawRect(0, 0, TSSAdminButton:GetWide(), 
				TSSAdminButton:GetTall())
				
				surface.SetDrawColor(0, 0, 0, 255)
				surface.DrawOutlinedRect(0, 0, TSSAdminButton:GetWide(), 
				TSSAdminButton:GetTall())
				
			end
			
			-- Set the image of the button (small icon16 aligned to the left)
			TSSAdminButton:SetImage(button.image)
			
			-- When clicking the button, get the relevant line and execute
			-- the function specified in the adminsButtonsInfo table
			TSSAdminButton.DoClick = function()
				button.func()
			end
			
			-- Add some margins so the buttons aren't attached to eachother
			-- DockMargin parameters are as follows (left, top, right, bottom)
			TSSAdminButton:DockMargin(10, 10, 30, 10)
			
			-- Lastly, add the button to the list of buttons
			TSSButtonsListLayout:Add(TSSAdminButton)
			
		end
		
	end

end
--------------------------------------------------------------------------------