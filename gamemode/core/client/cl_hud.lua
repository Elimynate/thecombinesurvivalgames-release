--------------------------------------------------------------------------------
-- [Declare Variables]
--------------------------------------------------------------------------------
-- Various player variables
local plyHealth
local plyMaxHealth
local plyHealthPercentage
local plyArmour
local plyMaxArmour
local plyArmourPercentage
local plyAmmoInClip
local plyAmmoReserve
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [HideHUD Function]
--------------------------------------------------------------------------------
function HideHUD(hudElementName)
	-- Hide default HUD
	for k,v in pairs({"CHudHealth", "CHudBattery", 
	"CHudAmmo", "CHudSecondaryAmmo"}) do
		if hudElementName == v then return false end
	end
end
hook.Add("HUDShouldDraw", "HideHUD", HideHUD)
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [DrawCustomHUD Function]
--------------------------------------------------------------------------------
function DrawCustomHUD()

	-- Draw our own HUD below
	if !LocalPlayer():Alive() then return end
	
	plyHealth = LocalPlayer():Health()
	plyMaxHealth = LocalPlayer():GetMaxHealth()
	plyHealthPercentage =  plyHealth/plyMaxHealth

	plyArmour = LocalPlayer():Armor()
	plyMaxArmour = 100
	plyArmourPercentage = plyArmour/plyMaxArmour

	plyStamina = LocalPlayer():GetNWInt("stamina")
	plyMaxStamina = 100
	plyStaminaPercentage = (plyStamina/plyMaxStamina)
	
	DrawHealth()
	DrawStamina()

	if(plyArmour > 0) then
		DrawArmour()
	end
	
	if(IsValid(LocalPlayer():GetActiveWeapon())) then
		plyAmmoInClip = LocalPlayer():GetActiveWeapon():Clip1()
		plyAmmoReserve = LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType())
		DrawAmmo()
	end
	
end
hook.Add("HUDPaint", "DrawCustomHUD", DrawCustomHUD)
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [PostDrawViewModel Function]
--------------------------------------------------------------------------------
function GM:PostDrawViewModel( vm, ply, weapon )
	-- Draw hands on screen client side
	if ( weapon.UseHands || !weapon:IsScripted() ) then
		local hands = LocalPlayer():GetHands()
		if ( IsValid( hands ) ) then hands:DrawModel() end
	end
end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [DrawHealth Function]
--------------------------------------------------------------------------------
local healthBarWidth = 384
local healthBarHeight = 32
local healthBarX = ScrW() - healthBarWidth - 44
local healthBarY = ScrH() - healthBarHeight - 42
local healthBarDiagDiff = -32
local healthBarBorder = 3
--------------------------------------------------------------------------------
function DrawHealth()

	DrawPolyBarDynamic(
		healthBarX,
		healthBarY,
		healthBarWidth,
		healthBarHeight,
		healthBarDiagDiff,
		healthBarBorder,
		Color(0, 0, 0, 200),
		Color(255, 255, 255, 255),
		Color(220,190,180,255),
		Color(250,135,50,255),
		plyHealthPercentage)
	
end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [DrawStamina Function]
--------------------------------------------------------------------------------
local staminaBarWidth = 384
local staminaBarHeight = 24
local staminaBarX = 44
local staminaBarY = ScrH() - healthBarHeight - 24
local staminaBarDiagDiff = 28
local staminaBarBorder = 3
--------------------------------------------------------------------------------	
function DrawStamina()

	DrawPolyBarDynamic(
		staminaBarX,
		staminaBarY,
		staminaBarWidth,
		staminaBarHeight,
		staminaBarDiagDiff,
		staminaBarBorder,
		Color(0, 0, 0, 200),
		Color(255, 255, 255, 255),
		Color(230,200,220,255),
		Color(255,110,200,255),
		plyStaminaPercentage)
	
end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [DrawArmour Function]
--------------------------------------------------------------------------------
local armourBarWidth = 320
local armourBarHeight = 16
local armourBarX = healthBarX + 64
local armourBarY = healthBarY - healthBarHeight - healthBarBorder*2
local armourBarDiagDiff = -28
local armourBarBorder = 3
--------------------------------------------------------------------------------	
function DrawArmour()

	DrawPolyBarDynamic(
		armourBarX,
		armourBarY,
		armourBarWidth,
		armourBarHeight,
		armourBarDiagDiff,
		armourBarBorder,
		Color(0, 0, 0, 200),
		Color(255, 255, 255, 255),
		Color(180,180,220,255),
		Color(110,110,200,255),
		plyArmourPercentage)
	
end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [DrawAmmo Function]
--------------------------------------------------------------------------------
function DrawAmmo()
	
	-- Draw the ammo the player has in their current weapon (only if that
	-- weapon has ammo and the current clip has atleast 1 bullet)
	if(plyAmmoInClip < 0) then return end

	local ammoBarEdgeThickness = 4
	local bulletThickness = 4
	local bulletSpacing = 3

	surface.SetDrawColor(0, 0, 0, 200)
	surface.DrawRect(

		ScrW() - 32, 
		healthBarY + healthBarHeight - (plyAmmoInClip * (bulletThickness + bulletSpacing) + ammoBarEdgeThickness * 2) 
		, 
		24, 
		plyAmmoInClip * (bulletThickness + bulletSpacing) + ammoBarEdgeThickness * 2 + ammoBarEdgeThickness/2

	)

	surface.SetDrawColor(255,255,255,255)
	surface.DrawRect(

		ScrW() - 32 + ammoBarEdgeThickness, 
		healthBarY + healthBarHeight - (plyAmmoInClip * (bulletThickness + bulletSpacing)) - ammoBarEdgeThickness, 
		24 - ammoBarEdgeThickness * 2, 
		plyAmmoInClip * (bulletThickness + bulletSpacing) + ammoBarEdgeThickness/2

	)

	surface.SetDrawColor(255,192,64,255)
	for i = 1, plyAmmoInClip do

		surface.DrawRect(

			ScrW() - 32 + ammoBarEdgeThickness*1.5,
			healthBarY + healthBarHeight - (plyAmmoInClip * (bulletThickness + bulletSpacing)) - ammoBarEdgeThickness
			+ (bulletSpacing + bulletThickness) * i - (bulletSpacing + bulletThickness - ammoBarEdgeThickness/2),
			24 - ammoBarEdgeThickness * 3,
			bulletThickness

		)

	end

	if(plyAmmoReserve > 0) then

		draw.SimpleText(plyAmmoReserve,
			"HUDInfoMedium",
			ScrW() - 8,
			ScrH() - 8,
			Color(255, 255, 255, 255),
			TEXT_ALIGN_RIGHT,
			TEXT_ALIGN_BOTTOM)

	end
	
end
--------------------------------------------------------------------------------