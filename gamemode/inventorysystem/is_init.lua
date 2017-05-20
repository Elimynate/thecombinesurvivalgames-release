--------------------------------------------------------------------------------
-- [Add CS Lua Files]
--------------------------------------------------------------------------------
-- [Client]
AddCSLuaFile("client/is_cl_inventorydisplay.lua")
AddCSLuaFile("client/is_cl_admin.lua")


-- [Shared]
AddCSLuaFile("shared/classes/is_sh_item.lua")
AddCSLuaFile("shared/classes/is_sh_itemsrepository.lua")

AddCSLuaFile("shared/items/is_sh_items_consumables.lua")
AddCSLuaFile("shared/items/is_sh_items_weapons.lua")
AddCSLuaFile("shared/items/is_sh_items_ammunitions.lua")

AddCSLuaFile("shared/is_sh_config.lua")
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [Includes]
--------------------------------------------------------------------------------
-- [Shared]
include("shared/classes/is_sh_item.lua")
include("shared/classes/is_sh_itemsrepository.lua")

include("shared/items/is_sh_items_consumables.lua")
include("shared/items/is_sh_items_weapons.lua")
include("shared/items/is_sh_items_ammunitions.lua")

include("shared/is_sh_config.lua")


-- [Server]
include("server/is_sv_functions.lua")
include("server/is_sv_concommands.lua")
include("server/classes/is_sv_inventory.lua")
--------------------------------------------------------------------------------