--------------------------------------------------------------------------------
-- [Declare Variables]
--------------------------------------------------------------------------------
base = nil
basePropertySheet = nil
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [Q Menu]
--------------------------------------------------------------------------------
qMenu = qMenu or {}

function qMenu:Show()
	
	-- Draw menu when pressing Q
	base = vgui.Create("DFrame")
	base:SetPos(0, 0)
	base:SetSize(ScrW()/1.5, 512)
	base:SetTitle("")
	base:SetVisible(true)
	base:SetDraggable(false)
	base:ShowCloseButton(false)
	base:Center()
	base.Paint = function(self, w, h) return end
	
	
	basePropertySheet = vgui.Create("DPropertySheet", base)
	basePropertySheet:SetPos(0 , 0)
	basePropertySheet:SetSize(base:GetWide(), base:GetTall())
	
	
	DrawInventory()
	DrawAdmin()
	DrawISAdmin()
	DrawTSSAdmin()
	
	
	base:MakePopup()
	
	
	function qMenu:Hide()
		base:Remove()
	end

end

function GM:OnSpawnMenuOpen(ply)
	qMenu:Show()
end

function GM:OnSpawnMenuClose(ply)
	qMenu:Hide()
end
--------------------------------------------------------------------------------