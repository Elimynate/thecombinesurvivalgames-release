--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- [Consumables]
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local milkCarton = Item(
	"prop_physics",
	"consumable.milkcarton",
	"Consumable",
	"tier3",
	"Carton of Milk",
	"A paperboard box that contains milk (10 Health)",
	"models/props_junk/garbage_milkcarton002a.mdl",
	0,
	true,
	true,
	false,
	30
)
milkCarton.Use = function(ply)

	ply:Heal(10)

end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local popCanGrape = Item(
	"prop_physics",
	"consumable.popcan.grape",
	"Consumable",
	"tier3",
	"Can of Grape Pop",
	"An aluminium beverage can containing grape pop (5 Health)",
	"models/props_junk/PopCan01a.mdl",
	0,
	true,
	true,
	true,
	20
)
popCanGrape.Use = function(ply)

	ply:Heal(5)

end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local popCanStrawberry = Item(
	"prop_physics",
	"consumable.popcan.strawberry",
	"Consumable",
	"tier3",
	"Can of Strawberry Pop",
	"An aluminium beverage can containing strawberry pop (5 Health)",
	"models/props_junk/PopCan01a.mdl",
	1,
	true,
	true,
	true,
	20
)
popCanStrawberry.Use = function(ply)

	ply:Heal(5)

end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local popCanLemonade = Item(
	"prop_physics",
	"consumable.popcan.lemonade",
	"Consumable",
	"tier3",
	"Can of Lemonade Pop",
	"An aluminium beverage can containing lemon pop (5 Health)",
	"models/props_junk/PopCan01a.mdl",
	2,
	true,
	true,
	true,
	20
)
popCanLemonade.Use = function(ply)

	ply:Heal(5)

end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local waterMelon = Item(
	"prop_physics",
	"consumable.watermelon",
	"Consumable",
	"tier2",
	"Watermelon",
	"A large fruit with a thick " ..
	"protective outer layer surrounding it's fleshy center (20 Health)",
	"models/props_junk/watermelon01.mdl",
	0,
	true,
	true,
	false,
	35
)
waterMelon.Use = function(ply)

	ply:Heal(20)

end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local medicalKit = Item(
	"prop_physics",
	"consumable.medkit",
	"Consumable",
	"tier1",
	"Medical Kit",
	"A collection of supplies used to give medical treatment (50 Health)",
	"models/weapons/w_medkit.mdl",
	0,
	true,
	true,
	false,
	25
)
medicalKit.Use = function(ply)

	ply:Heal(50)

end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
local armour = Item(
	"prop_physics",
	"consumable.armour",
	"Consumable",
	"tier1",
	"Armour",
	"Increases your armour (25 Armour)",
	"models/Items/battery.mdl",
	0,
	true,
	true,
	false,
	25
)
armour.Use = function(ply)

	local plyArmor = ply:Armor()
	plyArmor = plyArmor + 25
	if(plyArmor > 100) then
		plyArmor = 100
	end
	ply:SetArmor(plyArmor)

end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
itemsRepository.AddItem(milkCarton)
itemsRepository.AddItem(popCanGrape)
itemsRepository.AddItem(popCanStrawberry)
itemsRepository.AddItem(popCanLemonade)
itemsRepository.AddItem(waterMelon)
itemsRepository.AddItem(medicalKit)
itemsRepository.AddItem(armour)
--------------------------------------------------------------------------------