--------------------------------------------------------------------------------
-- [Declare Variables]
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [Scoreboard]
--------------------------------------------------------------------------------
scoreboard = scoreboard or {}

function scoreboard:Show()
	
	-- Scoreboard Base Frame
	local scoreboardBase = vgui.Create("DFrame")
	scoreboardBase:SetPos(0, 0)
	scoreboardBase:SetSize(1024, 384)
	scoreboardBase:SetTitle("")
	scoreboardBase:SetVisible(true)
	scoreboardBase:SetDraggable(false)
	scoreboardBase:ShowCloseButton(false)
	scoreboardBase:Center()
	scoreboardBase.Paint = function(self, w, h) return end
	
	-- A scroll panel to hold all the panels for each piece of information
	local scoreboardScrollPanel = vgui.Create("DScrollPanel", scoreboardBase)
	scoreboardScrollPanel:SetPos(0, 0)
	scoreboardScrollPanel:SetSize(scoreboardBase:GetWide() + 16, scoreboardBase:GetTall())
	
	-- A list layout so we can add panels to a list
	local scoreboardListForPanels = vgui.Create( "DListLayout", scoreboardScrollPanel )
	scoreboardListForPanels:SetPos(0, 0)
	scoreboardListForPanels:SetSize(scoreboardScrollPanel:GetWide(), scoreboardScrollPanel:GetTall())
	

	-- The first panel to appear in the list
	local titlePanel = vgui.Create("DPanel")
	titlePanel:SetPos(0, 0)
	titlePanel:SetSize(scoreboardBase:GetWide(), 128)
	titlePanel:DockMargin(20, 10, 20, 10)
	titlePanel:DockPadding(20, 10, 10, 10)
	titlePanel:SetContentAlignment(5)
	titlePanel:SetBackgroundColor(Color(255, 255, 255, 0))

	
	titlePanel["image"] = vgui.Create("DImage", titlePanel)
	titlePanel["image"]:SetPos(0, 0)
	titlePanel["image"]:SetSize(titlePanel:GetWide(), titlePanel:GetTall())
	titlePanel["image"]:SetImage("gui/tcsg/tcsgscoreboardimage.png")
	
	
	-- Add the title panel to the list
	scoreboardListForPanels:Add(titlePanel)
	



	-- Next create a panel regarding the players own city
	local yourCityPanel = vgui.Create("DPanel")
	yourCityPanel:SetPos(0, 0)
	yourCityPanel:SetSize(titlePanel:GetWide(), 64)
	yourCityPanel:DockMargin(20, 10, 20, 10)
	yourCityPanel:DockPadding(10, 10, 10, 10)



	-- Left side of panel regarding players own city
	local leftSideYourCityPanel = vgui.Create("DPanel", yourCityPanel)
	leftSideYourCityPanel:SetPos(0, 0)
	leftSideYourCityPanel:SetSize(yourCityPanel:GetWide()/3, 
	yourCityPanel:GetTall())

	leftSideYourCityPanel:SetBackgroundColor(
	team.GetColor(LocalPlayer():Team()))


	-- Set city name on left side of panel
	leftSideYourCityPanel["label"] = vgui.Create("DLabel", leftSideYourCityPanel)
	leftSideYourCityPanel["label"]:SetText( 
	team.GetName(LocalPlayer():Team()))
	
	leftSideYourCityPanel["label"]:SetDark(1)
	leftSideYourCityPanel["label"]:SetFont("ScoreboardPlayerRowFont")
	leftSideYourCityPanel["label"]:SizeToContents()
	leftSideYourCityPanel["label"]:DockPadding(10, 10, 10, 10)
	leftSideYourCityPanel["label"]:CenterVertical()
	leftSideYourCityPanel["label"]:CenterHorizontal()




	-- Right side of panel regarding players own city
	local rightSideYourCityFirstPanel = vgui.Create("DPanel", yourCityPanel)
	rightSideYourCityFirstPanel:SetPos(yourCityPanel:GetWide()/3, 0)
	rightSideYourCityFirstPanel:SetSize(yourCityPanel:GetWide()*2/3, 
	yourCityPanel:GetTall()/2)

	rightSideYourCityFirstPanel:SetBackgroundColor(
	team.GetColor(LocalPlayer():Team()))


	-- Set city team info on right side panel
	rightSideYourCityFirstPanel["label"] = vgui.Create("DLabel", rightSideYourCityFirstPanel)
	rightSideYourCityFirstPanel["label"]:SetFont("ScoreboardPlayerRowFont")
	rightSideYourCityFirstPanel["label"]:SetText(team.GetPlayers(LocalPlayer():Team())[1]:GetName())

	if(team.GetPlayers(LocalPlayer():Team())[1]:Alive()) then
		rightSideYourCityFirstPanel["label"]:SetTextColor(Color(255, 255, 255, 255))
	else
		rightSideYourCityFirstPanel["label"]:SetTextColor(Color(255, 0, 0, 255))
	end
	
	rightSideYourCityFirstPanel["label"]:SetDark(1)
	rightSideYourCityFirstPanel["label"]:SizeToContents()
	rightSideYourCityFirstPanel["label"]:DockPadding(10, 10, 10, 10)
	rightSideYourCityFirstPanel["label"]:CenterVertical()
	rightSideYourCityFirstPanel["label"]:CenterHorizontal()



	if(#team.GetPlayers(LocalPlayer():Team()) > 1) then
		-- Right side of panel regarding players city
		local rightSideYourCitySecondPanel = vgui.Create("DPanel", yourCityPanel)
		rightSideYourCitySecondPanel:SetPos(yourCityPanel:GetWide()/3, yourCityPanel:GetTall()/2)
		rightSideYourCitySecondPanel:SetSize(yourCityPanel:GetWide()*2/3, 
		yourCityPanel:GetTall()/2)

		rightSideYourCitySecondPanel:SetBackgroundColor(team.GetColor(LocalPlayer():Team()))

		-- Set city team info on right side panel
		rightSideYourCitySecondPanel["label"] = vgui.Create("DLabel", rightSideYourCitySecondPanel)
		rightSideYourCitySecondPanel["label"]:SetFont("ScoreboardPlayerRowFont")
		rightSideYourCitySecondPanel["label"]:SetText(team.GetPlayers(LocalPlayer():Team())[2]:GetName())

		if(team.GetPlayers(LocalPlayer():Team())[2]:Alive()) then
			rightSideYourCitySecondPanel["label"]:SetTextColor(Color(255, 255, 255, 255))
		else
			rightSideYourCitySecondPanel["label"]:SetTextColor(Color(255, 0, 0, 255))
		end
		
		rightSideYourCitySecondPanel["label"]:SetDark(1)
		rightSideYourCitySecondPanel["label"]:SizeToContents()
		rightSideYourCitySecondPanel["label"]:DockPadding(10, 10, 10, 10)
		rightSideYourCitySecondPanel["label"]:CenterVertical()
		rightSideYourCitySecondPanel["label"]:CenterHorizontal()
	end


	
	-- Add the player city information panel to the list
	scoreboardListForPanels:Add(yourCityPanel)
	
	-- Iterate through each team
	for k, city in pairs(team.GetAllTeams()) do
		
		-- If the team has atleast one player, add that city information
		-- to the scoreboard (except for the players own team)
		if(#team.GetPlayers(k) > 0 && k != LocalPlayer():Team()) then
			
			-- Next create a panel regarding the other players city
			local cityPanel = vgui.Create("DPanel")
			cityPanel:SetPos(0, 0)
			cityPanel:SetSize(titlePanel:GetWide(), 64)
			cityPanel:DockMargin(20, 10, 20, 10)
			cityPanel:DockPadding(10, 10, 10, 10)



			-- Left side of panel regarding players city
			local leftSideCityPanel = vgui.Create("DPanel", cityPanel)
			leftSideCityPanel:SetPos(0, 0)
			leftSideCityPanel:SetSize(cityPanel:GetWide()/3, 
			cityPanel:GetTall())

			leftSideCityPanel:SetBackgroundColor(team.GetColor(k))


			-- Set city name on left side of panel
			leftSideCityPanel["label"] = vgui.Create("DLabel", leftSideCityPanel)
			leftSideCityPanel["label"]:SetText(team.GetName(k))
			
			leftSideCityPanel["label"]:SetDark(1)
			leftSideCityPanel["label"]:SetFont("ScoreboardPlayerRowFont")
			leftSideCityPanel["label"]:SizeToContents()
			leftSideCityPanel["label"]:DockPadding(10, 10, 10, 10)
			leftSideCityPanel["label"]:CenterVertical()
			leftSideCityPanel["label"]:CenterHorizontal()


			local specificTeamPlayers = team.GetPlayers(k)

			-- Right side of panel regarding players city
			local rightSideFirstCityPanel = vgui.Create("DPanel", cityPanel)
			rightSideFirstCityPanel:SetPos(cityPanel:GetWide()/3, 0)
			rightSideFirstCityPanel:SetSize(cityPanel:GetWide()*2/3, 
			cityPanel:GetTall()/2)

			rightSideFirstCityPanel:SetBackgroundColor(team.GetColor(k))


			-- Set city team info on right side panel
			rightSideFirstCityPanel["label"] = vgui.Create("DLabel", rightSideFirstCityPanel)
			rightSideFirstCityPanel["label"]:SetFont("ScoreboardPlayerRowFont")
			rightSideFirstCityPanel["label"]:SetText(specificTeamPlayers[1]:GetName())

			if(specificTeamPlayers[1]:Alive()) then
				rightSideFirstCityPanel["label"]:SetTextColor(Color(255, 255, 255, 255))
			else
				rightSideFirstCityPanel["label"]:SetTextColor(Color(255, 0, 0, 255))
			end
			
			rightSideFirstCityPanel["label"]:SetDark(1)
			rightSideFirstCityPanel["label"]:SizeToContents()
			rightSideFirstCityPanel["label"]:DockPadding(10, 10, 10, 10)
			rightSideFirstCityPanel["label"]:CenterVertical()
			rightSideFirstCityPanel["label"]:CenterHorizontal()


			if(#specificTeamPlayers > 1) then
				-- Right side of panel regarding players city
				local rightSideSecondCityPanel = vgui.Create("DPanel", cityPanel)
				rightSideSecondCityPanel:SetPos(cityPanel:GetWide()/3, cityPanel:GetTall()/2)
				rightSideSecondCityPanel:SetSize(cityPanel:GetWide()*2/3, 
				cityPanel:GetTall()/2)

				rightSideSecondCityPanel:SetBackgroundColor(team.GetColor(k))

				-- Set city team info on right side panel
				rightSideSecondCityPanel["label"] = vgui.Create("DLabel", rightSideSecondCityPanel)
				rightSideSecondCityPanel["label"]:SetFont("ScoreboardPlayerRowFont")
				rightSideSecondCityPanel["label"]:SetText(specificTeamPlayers[2]:GetName())

				if(specificTeamPlayers[2]:Alive()) then
					rightSideSecondCityPanel["label"]:SetTextColor(Color(255, 255, 255, 255))
				else
					rightSideSecondCityPanel["label"]:SetTextColor(Color(255, 0, 0, 255))
				end
				
				rightSideSecondCityPanel["label"]:SetDark(1)
				rightSideSecondCityPanel["label"]:SizeToContents()
				rightSideSecondCityPanel["label"]:DockPadding(10, 10, 10, 10)
				rightSideSecondCityPanel["label"]:CenterVertical()
				rightSideSecondCityPanel["label"]:CenterHorizontal()
			end

			scoreboardListForPanels:Add(cityPanel)
			
		end
		
	end
	
	-- Mak the scoreboard popup
	scoreboardBase:MakePopup()
	
	function scoreboard:Hide()
		scoreboardBase:Remove()
	end
	
end

-- Make the scoreboard popup when pressing Tab
function GM:ScoreboardShow()
	scoreboard:Show()
end

-- Make the scoreboard disappear when releasing Tab
function GM:ScoreboardHide()
	scoreboard:Hide()
end
--------------------------------------------------------------------------------