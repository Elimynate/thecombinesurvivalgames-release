--------------------------------------------------------------------------------
-- [Breen Screencast]
--------------------------------------------------------------------------------
g_Breen = nil	-- Breen NPC

if ( SERVER ) then
	-- Broadcast propaganda to clients
	util.AddNetworkString( "BreencastSentence" )
end

-- Broadcast Breen to clients each time he starts a new sentence.
function GM:EntityEmitSound( data )

	if ( data.Entity == g_Breen ) then

		local st, en = string.find( data.SoundName, "vo/" )
		local sentence = "sound/"..string.sub( data.SoundName, st )	-- Properly format sound name

		net.Start( "BreencastSentence" )
			net.WriteEntity( data.Entity )
			net.WriteString( sentence )
		net.Broadcast()

	end

	return nil

end

if ( CLIENT ) then

	-- Receive latest breencast sound byte and update screen
	function BreencastSentence()

		-- Client-side reference to Breen NPC
		g_Breen = net.ReadEntity()

		local soundname = net.ReadString()

		-- Play sound byte
		sound.PlayFile( soundname, "", function( sentence, errnum, err )

			if ( err ) then
				Error( err )
			else
				sentence:Play()
				StartBreencast()	-- Update breencast monitor
			end

		end )

	end

	net.Receive( "BreencastSentence", BreencastSentence )

end

-- Call this server-side to begin Breencast
function StartBreencast()
	
	if ( SERVER ) then

		-- Remove existing Breen NPC
		if ( g_Breen && IsValid( g_Breen ) ) then
			g_Breen:Remove()
		end

		-- Create new Breen NPC
		g_Breen = ents.Create( "npc_breen" )
		g_Breen:Spawn()

		-- Hide NPC everywhere except inside model panel
		g_Breen:SetSaveValue( "m_takedamage", 0 )
		g_Breen:SetMoveType( MOVETYPE_NONE )
		g_Breen:SetSolid( SOLID_NONE )
		g_Breen:SetRenderMode( RENDERMODE_TRANSALPHA )
		g_Breen:SetColor( Color( 255, 255, 255, 0 ) )

		-- Play propaganda
		g_Breen:PlayScene("scenes/Breencast/overwatch.vcd")
		g_Breen:SetEyeTarget( Vector( 100, 0, 60 ) )

	elseif ( CLIENT ) then

		-- Remove existing panel and clear model entity to prevent error
		if ( BGPanel ) then
			if ( BGPanel:GetChild( 0 ) ) then BGPanel:GetChild( 0 ):SetEntity( nil ) end
			BGPanel:Remove()
			BGPanel = nil
		end

		-- Don't continue if Breen is undefined
		if ( !g_Breen or !IsValid( g_Breen ) ) then return end

		-- Black background panel
		BGPanel = vgui.Create( "DPanel" )
		BGPanel:SetPos( ScrW()/2-ScrW()/3/2, ScrH()-ScrW()/3 )
		BGPanel:SetSize( ScrW()/3, ScrW()/3 )
		BGPanel:SetBackgroundColor( Color( 0, 0, 0, 0 ) )

		-- Model panel
		local mdl = vgui.Create( "DModelPanel", BGPanel )
		mdl:SetSize(ScrW()/3, ScrW()/3)
		mdl:SetFOV(30)	-- Default FOV is too jarring

		mdl:SetEntity( g_Breen )	-- Add Breen NPC to model panel

		-- Focus camera on Breen's head
		function mdl:LayoutEntity( ent )

			-- If Breen has been removed somehow then remove screen
			if ( !IsValid( ent ) ) then
				if ( mdl:GetParent() ) then mdl:GetParent():Remove() end
				return
			end

			local eyepos = ent:GetBonePosition( ent:LookupBone( "ValveBiped.Bip01_Head1" ) )

			mdl:SetLookAt(eyepos)
			mdl:SetCamPos( eyepos+Vector( 45, 0, -8 ) )

			return

		end
		

	end

end
--------------------------------------------------------------------------------