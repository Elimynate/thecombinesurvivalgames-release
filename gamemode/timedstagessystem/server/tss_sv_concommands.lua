--------------------------------------------------------------------------------
-- [Allow Admin To Go To Next Stage]
--------------------------------------------------------------------------------
concommand.Add(

	-- Name of the concommand
	"tss_stage_next", 
	
	-- Function to execute when the concommand is called
	function(ply, cmd, args)
		if(!ply:IsAdmin()) then 
		
			ply:ChatPrint("You do not have Admin status!")
				
		else

			timedStagesSystem.NextStage()

		end

	end
	
)
--------------------------------------------------------------------------------