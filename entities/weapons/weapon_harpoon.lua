SWEP.PrintName			= "Harpoon"
SWEP.Author			= "Elimynate"
SWEP.Instructions		= "Left Mouse Click To Throw"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.UseHands			= true
SWEP.ViewModelFlip		= false
-------------Primary Fire Attributes----------------------------------------
SWEP.Primary.Damage         = 0.12
SWEP.Primary.ClipSize       = -1
SWEP.Primary.DefaultClip    = -1
SWEP.Primary.Automatic      = false
SWEP.Primary.Delay = 1.2
SWEP.Primary.Ammo       = "none"


SWEP.Secondary.Ammo       = "none"
SWEP.Secondary.ClipSize       = -1
SWEP.Secondary.DefaultClip    = -1
-------------End Primary Fire Attributes------------------------------------

SWEP.Weight			= 5
SWEP.AutoSwitchTo		= true
SWEP.AutoSwitchFrom		= false

SWEP.Slot			= 1
SWEP.SlotPos			= 2
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= true

SWEP.ViewModel			= "models/weapons/c_arms.mdl"
SWEP.WorldModel			= "models/props_junk/harpoon002a.mdl"

local ShootSound = Sound("weapons/iceaxe/iceaxe_swing1.wav")
local ImpactSound = Sound("physics/flesh/flesh_impact_hard3.wav")

function SWEP:Initialize()
	if( SERVER ) then
		self:SetWeaponHoldType("melee");
	end

end
--
-- Called when the left mouse button is pressed
--
function SWEP:PrimaryAttack()

	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	
	 if not IsValid(self.Owner) then return end
	
	self.Weapon:EmitSound(ShootSound)
	self.Weapon:SendWeaponAnim(ACT_VM_THROW)
	
	if SERVER then
		local bar = ents.Create("prop_physics")
		local damage = self.Primary.Damage
		local owner = self.Owner
		local wep = self
		bar:SetModel("models/props_junk/harpoon002a.mdl")
		bar:SetAngles(self.Owner:EyeAngles())
		bar:SetPos(self.Owner:GetShootPos())
		bar:SetOwner(self.Owner)
		bar:SetPhysicsAttacker(self.Owner)
		bar:Spawn()
		local phys = bar:GetPhysicsObject()
		phys:ApplyForceCenter(self.Owner:GetAimVector() * 300000)
		phys:AddAngleVelocity(Vector(0,70,0))
		local function collide(ent, data)
				
			math.randomseed(os.time())
			data.HitEntity:TakeDamage(math.random(30, 60), owner, wep)
			bar:Fire("kill", "", 5)
			
			if(data.HitEntity:IsPlayer()) then
				// Create a blood entity
				local blood = ents.Create("env_blood");
				// Bind it to an entity. I specify an entity type (since I only have 1).
				blood:SetKeyValue("parentname", data.HitEntity:GetName());
				// Give it the spawnflags of 8. (stream, I believe). Possibly unecessary.
				blood:SetKeyValue("spawnflags", 8);
				// Random direction
				blood:SetKeyValue("spraydir", math.random(500) .. " " .. math.random(500) .. " " .. math.random(500));
				// Huge spray amount to make big splatters.
				blood:SetKeyValue("amount", 250.0);
				// Tell it to only collide with the world.
				blood:SetCollisionGroup( COLLISION_GROUP_WORLD );
				// Set the position equal to the origin you want the blood to originate from.
				blood:SetPos( data.HitEntity:GetPos() );
				// Spawn the blood entity
				blood:Spawn();
				// Activate the effect.
				blood:Fire("EmitBlood");
				self.Weapon:EmitSound(ImpactSound)
			end

			

				
		end

		bar:AddCallback("PhysicsCollide", collide)
		self:Remove()
		
	end


end

function SWEP:SecondaryAttack()
	
end


function SWEP:Equip()
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
   	self.Weapon:SetNextPrimaryFire( CurTime() + (self.Primary.Delay * 1.5) )
end