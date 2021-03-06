require('gamemode')
function Spawn( entityKeyValues )
    ABILITY_toxin = thisEntity:FindAbilityByName("dk_toxin")
    ABILITY_demon_form = thisEntity:FindAbilityByName("dk_demon_form")

    thisEntity:SetContextThink( "cast", cast , 1)
    print("Starting AI for "..thisEntity:GetUnitName().." "..thisEntity:GetEntityIndex())

end

function cast()
if (thisEntity:GetHealth() / thisEntity:GetMaxHealth()) <= .50 then
    thisEntity:Stop()
    thisEntity:CastAbilityNoTarget(ABILITY_demon_form , -1)
	ParticleManager:CreateParticle("particles/units/heroes/hero_dragon_knight/dragon_knight_transform_black.vpcf", PATTACH_ABSORIGIN, thisEntity)
	print("casting demon form")
return 10
	end
    if (thisEntity:GetHealth() / thisEntity:GetMaxHealth()) <= .99 then
    thisEntity:Stop()
	local targetpos = thisEntity:GetAggroTarget():GetAbsOrigin()
		if targetpos == nil then
			targetpos = caster:GetAbsOrigin() + caster:GetForwardVector()
		end
    thisEntity:CastAbilityOnPosition(targetpos, ABILITY_toxin , -1)
	ParticleManager:CreateParticle("particles/dk_toxin.vpcf", PATTACH_ABSORIGIN, thisEntity:GetAggroTarget())
return 10
	end
    if thisEntity:GetAggroTarget() ~= nil then
		local distance_from_target = (thisEntity:GetOrigin() - thisEntity:GetAggroTarget():GetOrigin()):Length2D()
		if distance_from_target >= 550 then
			thisEntity:Stop()
			thisEntity:SetAggroTarget(nil)
		return .1 
		end
	return .1
	end
	if thisEntity:GetAggroTarget() == nil then
		local radiant = (thisEntity:GetAbsOrigin() - Entities:FindByName(nil, "rad_boss_sk"):GetAbsOrigin()):Length2D()
		local dire = (thisEntity:GetAbsOrigin() - Entities:FindByName(nil, "dire_boss_sk"):GetAbsOrigin()):Length2D()
		local closest = Entities:FindByName(nil, "rad_boss_sk"):GetAbsOrigin()
		if radiant < dire then
			closest = Entities:FindByName(nil, "rad_boss_sk"):GetAbsOrigin()
		else
			closest = Entities:FindByName(nil, "dire_boss_sk"):GetAbsOrigin()
		end
		if (closest - thisEntity:GetAbsOrigin()):Length2D() >= 550 then
			thisEntity:MoveToPosition(closest)
		end
	return .1
	end
return .1
end
