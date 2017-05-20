--------------------------------------------------------------------------------
-- [DrawPolyBar]
--------------------------------------------------------------------------------
function DrawPolyBar(startX, startY, width, height, diagDiff, border,
	borderColour, barColour)

	if(border > 0) then

		local polyBarBorder =
		{
			{ 	x = startX - border, 
				y = startY + border},

			{ 	x = startX - border, 
				y = startY - height - border},

			{ 	x = startX + width + border, 
				y = startY - height - 
				diagDiff - border},

			{ 	x = startX + width + border, 
				y = startY - diagDiff 
				+ border}
		}

		surface.SetDrawColor(borderColour)
		draw.NoTexture()
		surface.DrawPoly(polyBarBorder)

	end
	
	local polyBar =
	{
		{ 	x = startX , 
			y = startY },

		{ 	x = startX , 
			y = startY - height },

		{ 	x = startX + width , 
			y = startY - height -
			diagDiff  },

		{ 	x = startX + width , 
			y = startY - diagDiff }
	}
	
	surface.SetDrawColor(barColour)
	draw.NoTexture()
	surface.DrawPoly(polyBar)

end
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [DrawPolyBarDynamic]
--------------------------------------------------------------------------------
function DrawPolyBarDynamic(startX, startY, width, height, diagDiff, border,
	borderColour, bgColour, dynamicBGColour, dynamicColour, dynamicValue)

	if(border > 0) then

		local polyBarBorder =
		{
			{ 	x = startX - border, 
				y = startY + border},

			{ 	x = startX - border, 
				y = startY - height - border},

			{ 	x = startX + width + border, 
				y = startY - height - 
				diagDiff - border},

			{ 	x = startX + width + border, 
				y = startY - diagDiff 
				+ border}
		}

		surface.SetDrawColor(borderColour)
		draw.NoTexture()
		surface.DrawPoly(polyBarBorder)

	end
	
	local polyBarBG =
	{
		{ 	x = startX , 
			y = startY },

		{ 	x = startX , 
			y = startY - height },

		{ 	x = startX + width , 
			y = startY - height -
			diagDiff  },

		{ 	x = startX + width , 
			y = startY - diagDiff }
	}
	
	surface.SetDrawColor(bgColour)
	draw.NoTexture()
	surface.DrawPoly(polyBarBG)

	local polyBarDynamicValueBG =
	{
		{ 	x = startX + 5, 
			y = startY - 5 },

		{ 	x = startX + 5, 
			y = startY - height + 5 },

		{ 	x = startX + width - 5, 
			y = startY - height + 5 -
			diagDiff },

		{ 	x = startX + width - 5, 
			y = startY - diagDiff - 5 }
	}

	surface.SetDrawColor(dynamicBGColour)
	draw.NoTexture()
	surface.DrawPoly(polyBarDynamicValueBG)

	local polyBarDynamicValue =
	{
		{ 	x = startX + 5, 
			y = startY - 5 },

		{ 	x = startX + 5, 
			y = startY - height + 5 },

		{ 	x = startX + dynamicValue*(width-5), 
			y = startY - height + 5 -
			(dynamicValue * diagDiff) },

		{ 	x = startX + dynamicValue*(width-5),
			y = startY -
			(dynamicValue * diagDiff) - 5}
	}

	surface.SetDrawColor(dynamicColour)
	draw.NoTexture()
	surface.DrawPoly(polyBarDynamicValue)

end
--------------------------------------------------------------------------------