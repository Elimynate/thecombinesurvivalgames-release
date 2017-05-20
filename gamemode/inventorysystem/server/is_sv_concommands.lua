--------------------------------------------------------------------------------
-- [Add Item To Player Inventory ConCommand]
--------------------------------------------------------------------------------
concommand.Add(

	-- Name of the concommand
	"is_item_give", 
	
	-- Function to execute when the concommand is called
	function(ply, cmd, args)
		if(!ply:IsAdmin()) then 
		
			ply:ChatPrint("You do not have Admin status!")
				
		else

			local playerToAffect = FindPlayer(args[1])
			local itemToGive = itemsRepository.GetItem(args[2])
			local amountToAdd = tonumber(args[3])

			if(playerToAffect and itemToGive and amountToAdd) then

				if(playerToAffect:AddToInventory(itemToGive, amountToAdd)) then

					playerToAffect:ChatPrint(ply:GetName() .. 
					" (Admin) gave you " .. amountToAdd .. 
					"x " .. itemToGive.GetItemName())

					playerToAffect:ForceClientSideInventoryUpdate()

					ply:ChatPrint("You gave " .. playerToAffect:GetName() ..
					" " .. amountToAdd .. "x " .. itemToGive.GetItemName())

				else

					ply:ChatPrint(playerToAffect:GetName() .. "'s " ..
					"inventory is full, unable to add " .. amountToAdd ..
					"x " .. itemToGive.GetItemName())

				end
				
			end

		end

	end
	
)
--------------------------------------------------------------------------------