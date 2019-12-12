function burstHeal(keys)
	local caster = keys.caster
	local loc = caster:GetOrigin()
	local ability = keys.ability
	local caster_team = caster:GetTeamNumber()
	local max_charges = 45

if ability:GetCurrentCharges() > 0 then 
ability:SetCurrentCharges(ability:GetCurrentCharges() - 1)
else
	local distance = ability:GetSpecialValueFor("heal_radius")
	local healing_amount = ability:GetSpecialValueFor("heal_amount")
	local ally_units = FindUnitsInRadius(caster_team, loc, nil, distance,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
	print("burst heal activated")
	keys.caster:EmitSound("DOTA_Item.Mekansm.Activate")
	ParticleManager:CreateParticle("particles/items/auto_mek.vpcf", PATTACH_ABSORIGIN_FOLLOW, keys.caster)
	for number,entity in pairs(ally_units) do

		entity:Heal(healing_amount , caster)
		ParticleManager:CreateParticle("particles/items/auto_mek.vpcf", PATTACH_ABSORIGIN_FOLLOW, entity)

	end
ability:SetCurrentCharges(45)
end


end
