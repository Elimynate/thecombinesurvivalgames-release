--------------------------------------------------------------------------------
-- Keeping track of the current stage and displaying the time left in a readable
-- friendly format (00:00)
local curStageName = "-"
local curStageLength = 9999
local curStageColour = Color(255, 255, 255, 255)
local curStageStartTime = CurTime()

local curStageTimeLeft = 0
local m = 0 -- minutes
local s = 0 -- seconds
local timeLeftToDisplay = "00:00"
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [Net Receivals]
--------------------------------------------------------------------------------	
net.Receive("ClientUpdateStageInformation", function()
	
	-- Whenever a new stage starts or the client joins
	-- update this information so it is displayed properly for
	-- the client
	curStageName = net.ReadString()
	curStageLength = net.ReadInt(16)
	curStageStartTime = net.ReadFloat()
	curStageColour = net.ReadColor()
		
end)
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [HUDPaint Function]
--------------------------------------------------------------------------------
hook.Add("HUDPaint", "DrawStages", function()

	-- Draw information relating to the current stage
	draw.RoundedBox(8, ScrW()/2 - 192, ScrH() - 104, 384, 80, Color(150, 150, 150, 100))

	curStageTimeLeft = math.Round((curStageStartTime + curStageLength) 
									- CurTime())
									
	m = math.floor(curStageTimeLeft/60)
	s = (curStageTimeLeft - math.floor(curStageTimeLeft/60)*60)
	
	timeLeftToDisplay = string.format("%02d:%02d", m, s)
	
	draw.SimpleTextOutlined(curStageName,
							"StageNameFont", 
							ScrW()/2, 
							ScrH() - 80, 
							curStageColour, 
							TEXT_ALIGN_CENTER, 
							TEXT_ALIGN_CENTER, 
							1, 
							color_black)
							
	local timeLeftColour = Color(255,255,255,255)
	
	if(curStageTimeLeft <= 5) then timeLeftColour = Color(255,0,0,255) end
	
	draw.SimpleTextOutlined(timeLeftToDisplay,
							"StageTimeFont", 
							ScrW()/2, 
							ScrH() - 48, 
							timeLeftColour, 
							TEXT_ALIGN_CENTER, 
							TEXT_ALIGN_CENTER, 
							1, 
							color_black)

end)
--------------------------------------------------------------------------------