--------------------------------------------------------------------------------
-- [Declare Variables]
--------------------------------------------------------------------------------
local tcsgBanner = Material("gui/tcsg/tcsgscoreboardimage.png", "noclamp")
local tcsgTokens = Material("gui/tcsg/tcsgtokens.png", "noclamp")
local tcsgVictories = Material("gui/tcsg/tcsgvictories.png", "noclamp")
local tcsgKills = Material("gui/tcsg/tcsgkills.png", "noclamp")
local tcsgDeaths = Material("gui/tcsg/tcsgdeaths.png", "noclamp")

local mostVictoriesPlayerName
local mostVictoriesCount
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [Net Receivals]
--------------------------------------------------------------------------------	
net.Receive("ClientUpdateTCSGStatsForDisplay", function()
	
	mostVictoriesPlayerName = net.ReadString()
	mostVictoriesCount = net.ReadInt(16)
		
end)
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [DrawTCSGStats3D2D Function]
--------------------------------------------------------------------------------	
function DrawTCSGStats3D2D()
 
	DrawGamemodeInfo3D2D()
	DrawGamemodeHelp3D2D()
 	DrawYourStats3D2D()
	DrawTopPlayersStats3D2D()
 
end
hook.Add("PostDrawOpaqueRenderables", "DrawTCSGStats3D2D", DrawTCSGStats3D2D)
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [DrawGamemodeInfo3D2D Function]
--------------------------------------------------------------------------------	
function DrawGamemodeInfo3D2D()
 
	cam.Start3D2D(Vector(831, -831, 8472), Angle( 0, -135, 90), 1)

		draw.RoundedBox(8, -288, -304, 576, 512, Color(255, 255, 255, 25))

		surface.SetMaterial(tcsgBanner)
	    surface.SetDrawColor(color_white)
		surface.DrawTexturedRect(
			-256,
			-256,
			512,
			64
		)

		local noOfPlayers = ""
		for i = 1, #player.GetAll(), 1 do
			noOfPlayers = noOfPlayers .. "H"
		end

		draw.SimpleTextOutlined(
			noOfPlayers,
			"CSD", 
			0,
			-160,
			Color(200,200,200,255), 
			TEXT_ALIGN_CENTER,
			TEXT_ALIGN_CENTER,
			1, 
			color_black
		)

		draw.SimpleTextOutlined(
			"Overview",
			"HUDInfoLarge", 
			-216,
			-96,
			Color(200,100,45,255), 
			TEXT_ALIGN_CENTER,
			TEXT_ALIGN_CENTER,
			2, 
			color_black
		)

		draw.DrawText(
			"In this alternate timeline the Combine Forces crushed the Resistance\n" ..
			"during the events that took place in the Half-Life 2 series. To solidify\n" ..
			"their control over the remaining human population, the Advisors\n" ..
			"established the Combine Survival Games after their decisive victory against\n" ..
			"the Resistance. Humans with approved Anticitizen status are sent to an\n" ..
			"arena weekly nearest to their city in groups of twenty-four and are forced\n" ..
			"to fight against one another.\n\n\n" ..

			"The main event sees twenty-four citizens with approved Anticitizen status\n" ..
			"survive in an arena for as long as possible. The arena is dotted with loot\n" ..
			"containers that participants can break open in the hopes of getting something\n" ..
			"they need. The event ends when there is only one Anticitizen left alive.",
			
			"QMenuMedium", 
			-272,
			-64,
			Color(255,255,255,255), 
			TEXT_ALIGN_LEFT,  
			color_black
		)

	cam.End3D2D()
 
end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [DrawGamemodeHelp3D2D Function]
--------------------------------------------------------------------------------	
function DrawGamemodeHelp3D2D()
 
	cam.Start3D2D(Vector(304, -1132, 8472), Angle( 0, -165, 90), 1)

		draw.RoundedBox(8, -288, -304, 576, 512, Color(255, 255, 255, 25))

		draw.SimpleTextOutlined(
			"Help/Info",
			"HUDInfoLarge", 
			-216,
			-224,
			Color(45,145,200,255), 
			TEXT_ALIGN_CENTER,
			TEXT_ALIGN_CENTER,
			2, 
			color_black
		)

		draw.DrawText(
			"Items can be picked up by pressing E on them.\n\n" ..
			"You can open your inventory by holding Q. Items can be used or dropped\n" ..
			"from the inventory menu.\n\n" ..
			"Break open crates to get loot during the Survival Games stage.",

			"QMenuMedium", 
			-272,
			-192,
			Color(255,255,255,255), 
			TEXT_ALIGN_LEFT,  
			color_black
		)

	cam.End3D2D()
 
end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [DrawYourStats3D2D Function]
--------------------------------------------------------------------------------	
function DrawYourStats3D2D()
 
	cam.Start3D2D(Vector(-304, -1132, 8472), Angle( 0, -195, 90), 1)

		draw.RoundedBox(8, -288, -304, 576, 512, Color(255, 255, 255, 25))

		draw.SimpleTextOutlined(
			"Your Stats",
			"HUDInfoLarge", 
			0,
			-224,
			Color(115,145,40,255), 
			TEXT_ALIGN_CENTER,
			TEXT_ALIGN_CENTER,
			2, 
			color_black
		)

		draw.SimpleTextOutlined(
			LocalPlayer():GetName(),
			"HUDInfoVeryLarge", 
			0,
			-176,
			Color(255,255,255,255), 
			TEXT_ALIGN_CENTER, 
			TEXT_ALIGN_CENTER, 
			2, 
			color_black
		)

		draw.SimpleTextOutlined(
			LocalPlayer():GetNWInt("victories"),
			"HUDInfoLarge", 
			0,
			-104,
			Color(255,235,170,255), 
			TEXT_ALIGN_CENTER, 
			TEXT_ALIGN_CENTER, 
			1, 
			color_black
		)

		surface.SetMaterial(tcsgVictories)
	    surface.SetDrawColor(color_white)
		surface.DrawTexturedRect(
			-48,
			-96,
			96,
			96
		)

		surface.SetMaterial(tcsgTokens)
	    surface.SetDrawColor(color_white)
		surface.DrawTexturedRect(
			-16,
			0,
			32,
			32
		)

		draw.SimpleTextOutlined(
			LocalPlayer():GetNWInt("tokens"),
			"HUDInfoMedium", 
			-24,
			16,
			Color(255,255,255,255), 
			TEXT_ALIGN_RIGHT, 
			TEXT_ALIGN_CENTER, 
			1, 
			color_black
		)

		 surface.SetMaterial(tcsgKills)
	    surface.SetDrawColor(color_white)
		surface.DrawTexturedRect(
			-16,
			36,
			32,
			32
		) 

		draw.SimpleTextOutlined(
			LocalPlayer():GetNWInt("kills"),
			"HUDInfoMedium", 
			24,
			52,
			Color(255,255,255,255), 
			TEXT_ALIGN_LEFT, 
			TEXT_ALIGN_CENTER, 
			1, 
			color_black
		)

		 surface.SetMaterial(tcsgDeaths)
	    surface.SetDrawColor(color_white)
		surface.DrawTexturedRect(
			-12,
			76,
			24,
			24
		) 

		draw.SimpleTextOutlined(
			LocalPlayer():GetNWInt("deaths"),
			"HUDInfoMedium", 
			-24,
			88,
			Color(255,255,255,255), 
			TEXT_ALIGN_RIGHT, 
			TEXT_ALIGN_CENTER, 
			1, 
			color_black
		)

	cam.End3D2D()
 
end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [DrawTopPlayersStats3D2D Function]
--------------------------------------------------------------------------------	
function DrawTopPlayersStats3D2D(ply)
 
	cam.Start3D2D(Vector(-831, -831, 8472), Angle( 0, -225, 90), 1)

		draw.RoundedBox(8, -288, -304, 576, 512, Color(255, 255, 255, 25))

		--[[ draw.SimpleTextOutlined(
			"Games",
			"3D2DHuge", 
			0,
			-224,
			Color(255,221,91,255), 
			TEXT_ALIGN_CENTER,
			TEXT_ALIGN_CENTER,
			3, 
			color_black
		)--]] 

		draw.SimpleTextOutlined(
			"Most Victories",
			"HUDInfoLarge", 
			0,
			-224,
			Color(120,120,170,255), 
			TEXT_ALIGN_CENTER,
			TEXT_ALIGN_CENTER,
			2, 
			color_black
		)

		draw.SimpleTextOutlined(
			mostVictoriesPlayerName,
			"HUDInfoVeryLarge", 
			0,
			-176,
			Color(255,255,255,255), 
			TEXT_ALIGN_CENTER, 
			TEXT_ALIGN_CENTER, 
			1, 
			color_black
		)

		draw.SimpleTextOutlined(
			mostVictoriesCount,
			"HUDInfoLarge", 
			0,
			-104,
			Color(255,235,170,255), 
			TEXT_ALIGN_CENTER, 
			TEXT_ALIGN_CENTER, 
			1, 
			color_black
		)

		surface.SetMaterial(tcsgVictories)
	    surface.SetDrawColor(color_white)
		surface.DrawTexturedRect(
			-48,
			-96,
			96,
			96
		)

	cam.End3D2D()
 
end
--------------------------------------------------------------------------------