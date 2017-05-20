--------------------------------------------------------------------------------
-- [Declare Variables]
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [ClientInitialSpawnMenuPopup Net Receival]
--------------------------------------------------------------------------------
net.Receive("ClientInitialSpawnMenuPopup", function(len, ply)

	local infoFrame = vgui.Create("DFrame")
	infoFrame:SetPos(0, 0)
	infoFrame:SetSize(ScrW()/1.5, 384)
	infoFrame:SetTitle("")
	infoFrame:SetVisible(true)
	infoFrame:SetDraggable(false)
	infoFrame:ShowCloseButton(false)
	infoFrame:Center()
	infoFrame.Paint = function(self, w, h) return end
	infoFrame:MakePopup()

	local tcsgBanner = vgui.Create("DImage", infoFrame)
	tcsgBanner:SetSize(infoFrame:GetTall()/infoFrame:GetWide() * 2048, infoFrame:GetTall()/infoFrame:GetWide() * 256)
	tcsgBanner:SetPos(infoFrame:GetWide()/2 - tcsgBanner:GetWide()/2, 0)
	tcsgBanner:SetImage("gui/tcsg/tcsgscoreboardimage.png")


	local bgPanel = vgui.Create("DPanel", infoFrame)
	bgPanel:SetSize(infoFrame:GetWide(), infoFrame:GetTall() - tcsgBanner:GetTall())
	bgPanel:SetPos(0, tcsgBanner:GetTall())
	bgPanel.Paint = function( self, w, h ) 
		draw.RoundedBox(0, 0, 0, w, h, Color(120,120,170,255))
	end

	local popupLabel = vgui.Create("DLabel", bgPanel)
	popupLabel:SetDark(true)
	popupLabel:SetFont("HUDInfoMedium")
	popupLabel:SetText("Welcome to The Combine Survival Games server.\nDuring the survival" ..
		" games you can pick items up by pressing E.\nWeapons are automatically equipped." ..
		"\nYou can access your inventory by holding Q and perform actions by clicking on items.")
	popupLabel:SetPos(32, 32)
	popupLabel:SetSize(bgPanel:GetWide() - 32, bgPanel:GetTall() - 32)
	popupLabel:SetWrap(true)

	local closeButton = vgui.Create("DButton", infoFrame)
	closeButton:SetText("Okay")
	closeButton:SetTextColor(Color(255, 255, 255, 255))
	closeButton:SetSize(128, 32)
	closeButton:SetPos(infoFrame:GetWide()/2 - closeButton:GetWide()/2, infoFrame:GetTall() - closeButton:GetTall() * 2)
	closeButton.DoClick = function()
		infoFrame:Remove()
	end

end)
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [ClientInitialSpawnMenuPopup Net Receival]
--------------------------------------------------------------------------------
net.Receive("ClientEndGameBarrierNotify", function(len, ply)

	endGameBarrierNotification = vgui.Create("DNotify")
	endGameBarrierNotification:SetPos(0, ScrH() - 192)
	endGameBarrierNotification:SetSize(384, 80)
	endGameBarrierNotification:CenterHorizontal()

	local bgFrame = vgui.Create("DPanel", endGameBarrierNotification)
	bgFrame:SetSize(endGameBarrierNotification:GetWide(), endGameBarrierNotification:GetTall())
	bgFrame:Dock(FILL)
	bgFrame:SetBackgroundColor(Color(150, 150, 150, 100))

	local notificationLabel = vgui.Create("DLabel", bgFrame)
	notificationLabel:SetPos(16, 8)
	notificationLabel:SetSize(bgFrame:GetWide() - 16, bgFrame:GetTall() - 8)
	notificationLabel:SetText("Two minutes remain, barriers have been deployed!")
	notificationLabel:SetFont("StageTimeFont")
	notificationLabel:SetTextColor(Color(245, 205, 65, 255))
	notificationLabel:SetWrap(true)

	endGameBarrierNotification:AddItem(bgFrame)

end)
--------------------------------------------------------------------------------