require('gamemode')
function Spawn( entityKeyValues )
    ABILITY_toxin = thisEntity:FindAbilityByName("dk_toxin")
    ABILITY_demon_form = thisEntity:FindAbilityByName("dk_demon_form")

    thisEntity:SetContextThink( "cast", cast , 1)
    print("Starting AI for "..thisEntity:GetUnitName().." "..thisEntity:GetEntityIndex())

end

function cast()
    if (thisEntity:GetHealth() / thisEntity:GetMaxHealth()) <= .99 then
    thisEntity:Stop()
    thisEntity:CastAbilityOnPosition(thisEntity:GetAggroTarget():GetAbsOrigin(), ABILITY_toxin , -1)
	ParticleManager:CreateParticle("particles/dk_toxin.vpcf", PATTACH_ABSORIGIN, thisEntity:GetAggroTarget())
return 21
	end
	if (thisEntity:GetHealth() / thisEntity:GetMaxHealth()) <= .50 then
    thisEntity:Stop()
    thisEntity:CastAbilityNoTarget(ABILITY_demon_form , -1)
	ParticleManager:CreateParticle("particles/units/heroes/hero_dragon_knight/dragon_knight_transform_black.vpcf", PATTACH_ABSORIGIN, thisEntity:GetAbsOrigin())
return 51
    end
    if thisEntity:GetAggroTarget() ~= nil then
local distance_from_target = (thisEntity:GetOrigin() - thisEntity:GetAggroTarget():GetOrigin()):Length2D()
if distance_from_target >= 750 then
    thisEntity:SetAggoTarget(nil)
return .1 
end
return .1
end
return .1
end
