--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- [Weapons]
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local pistol = Item(
	"weapon_pistol",
	"weapon.pistol",
	"Weapon",
	"tier2",
	"Pistol",
	"A handheld pistol.",
	"models/weapons/w_pistol.mdl",
	0,
	true,
	true,
	false,
	20
)
pistol.Use = function(ply)

	ply:Give("weapon_pistol")

end
pistol.AlreadyUsed = function(ply)

	return ply:HasWeapon("weapon_pistol")

end
pistol.UseAndAlreadyUsed = function(ply)

	ply:GiveAmmo(8, "pistol")

end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local harpoon = Item(
	"weapon_harpoon",
	"weapon.harpoon",
	"Weapon",
	"tier3",
	"Harpoon",
	"A throwable harpoon",
	"models/props_junk/harpoon002a.mdl",
	0,
	true,
	true,
	false,
	96
)
harpoon.Use = function(ply)

	ply:Give("weapon_harpoon")

end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local axe = Item(
	"weapon_axe",
	"weapon.axe",
	"Weapon",
	"tier3",
	"Axe",
	"An axe",
	"models/weapons/w_crowbar.mdl",
	0,
	true,
	true,
	false,
	96
)
axe.Use = function(ply)

	ply:Give("weapon_axe")

end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local crowbar = Item(
	"weapon_crowbar",
	"weapon.crowbar",
	"Weapon",
	"tier2",
	"Crowbar",
	"A crowbar that can be used to force apart two objects",
	"models/weapons/w_crowbar.mdl",
	0,
	true,
	true,
	false,
	48
)
crowbar.Use = function(ply)

	ply:Give("weapon_crowbar")

end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local bugbait = Item(
	"weapon_bugbait",
	"weapon.bugbait",
	"Weapon",
	"tier3",
	"Bugbait",
	"A pheropod harvested from an antlion",
	"models/weapons/w_bugbait.mdl",
	0,
	true,
	true,
	false,
	16
)
bugbait.Use = function(ply)

	ply:Give("weapon_bugbait")

end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local smg = Item(
	"weapon_smg1",
	"weapon.smg",
	"Weapon",
	"tier1",
	"SMG",
	"A submachine gun",
	"models/weapons/w_smg1.mdl",
	0,
	true,
	true,
	false,
	32
)
smg.Use = function(ply)

	ply:Give("weapon_smg1")

end
smg.AlreadyUsed = function(ply)

	return ply:HasWeapon("weapon_smg1")

end
smg.UseAndAlreadyUsed = function(ply)

	ply:GiveAmmo(16, "smg1")

end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local crossbow = Item(
	"weapon_crossbow",
	"weapon.crossbow",
	"Weapon",
	"tier1",
	"Crossbow",
	"A crossbow",
	"models/weapons/w_crossbow.mdl",
	0,
	true,
	true,
	false,
	64
)
crossbow.Use = function(ply)

	ply:Give("weapon_crossbow")

end
crossbow.AlreadyUsed = function(ply)

	return ply:HasWeapon("weapon_crossbow")

end
crossbow.UseAndAlreadyUsed = function(ply)

	ply:GiveAmmo(4, "xbowbolt")

end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local revolver = Item(
	"weapon_357",
	"weapon.revolver",
	"Weapon",
	"tier1",
	"Revolver",
	"A revolver",
	"models/weapons/w_357.mdl",
	0,
	true,
	true,
	false,
	48
)
revolver.Use = function(ply)

	ply:Give("weapon_357")

end
revolver.AlreadyUsed = function(ply)

	return ply:HasWeapon("weapon_357")

end
revolver.UseAndAlreadyUsed = function(ply)

	ply:GiveAmmo(6, "357")

end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
itemsRepository.AddItem(pistol)
itemsRepository.AddItem(harpoon)
--itemsRepository.AddItem(axe)
itemsRepository.AddItem(crowbar)
itemsRepository.AddItem(bugbait)
itemsRepository.AddItem(smg)
itemsRepository.AddItem(crossbow)
itemsRepository.AddItem(revolver)
--------------------------------------------------------------------------------