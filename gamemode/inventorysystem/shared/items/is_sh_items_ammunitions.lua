--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- [Ammunitions]
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local pistolAmmo = Item(
	"prop_physics",
	"ammo.pistol",
	"Ammunition",
	"tier2",
	"Pistol Ammo",
	"Ammunition box with 8 bullets for the handheld pistol",
	"models/items/boxsrounds.mdl",
	0,
	true,
	true,
	false,
	40
)
pistolAmmo.Use = function(ply)

	ply:GiveAmmo(8, "pistol")

end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local smgAmmo = Item(
	"prop_physics",
	"ammo.smg",
	"Ammunition",
	"tier2",
	"SMG Ammo",
	"Ammunition box with 16 bullets for the submachine gun",
	"models/items/boxmrounds.mdl",
	0,
	true,
	true,
	false,
	48
)
smgAmmo.Use = function(ply)

	ply:GiveAmmo(16, "smg1")

end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local crossbowAmmo = Item(
	"prop_physics",
	"ammo.crossbow",
	"Ammunition",
	"tier2",
	"Crossbow Ammo",
	"4 crossbow bolts for the crossbow",
	"models/items/crossbowrounds.mdl",
	0,
	true,
	true,
	false,
	32
)
crossbowAmmo.Use = function(ply)

	ply:GiveAmmo(4, "xbowbolt")

end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local revolverAmmo = Item(
	"prop_physics",
	"ammo.revolver",
	"Ammunition",
	"tier2",
	"Revolver Ammo",
	"Ammunition box with 6 bullets for the revolver",
	"models/items/357ammobox.mdl",
	0,
	true,
	true,
	false,
	32
)
revolverAmmo.Use = function(ply)

	ply:GiveAmmo(6, "357")

end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
itemsRepository.AddItem(pistolAmmo)
itemsRepository.AddItem(smgAmmo)
itemsRepository.AddItem(crossbowAmmo)
itemsRepository.AddItem(revolverAmmo)
--------------------------------------------------------------------------------