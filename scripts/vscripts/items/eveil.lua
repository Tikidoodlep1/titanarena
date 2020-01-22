function Damage(keys)
local caster = keys.caster
local point = caster:GetCursorPosition()
local ability = keys.ability
local radius = ability:GetSpecialValueFor("debuff_radius")
local mult = ability:GetSpecialValueFor("attribute_mult")
local base = ability:GetSpecialValueFor("base_damage")
local debuffduration = ability:GetSpecialValueFor("resist_debuff_duration")
local units = FindUnitsInRadius(caster:GetTeamNumber(), point, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
local damagedealt = (caster:GetPrimaryStatValue() * mult) + base
	for _, hero in pairs(units) do
		local damageTable = {victim = hero, attacker = caster, damage = damagedealt, damage_type = DAMAGE_TYPE_MAGICAL}
		ApplyDamage(damageTable)
		local effect = ParticleManager:CreateParticle("particles/items_fx/ethereal_blade_explosion.vpcf", PATTACH_CUSTOMORIGIN, hero)
		ParticleManager:SetParticleControl(effect, 0, hero:GetAbsOrigin())
		ParticleManager:SetParticleControl(effect, 1, hero:GetAbsOrigin())
		ParticleManager:SetParticleControl(effect, 2, hero:GetAbsOrigin())
		ParticleManager:SetParticleControl(effect, 8, hero:GetAbsOrigin())
		ability:ApplyDataDrivenModifier(caster, hero, "modifier_eveil", {duration=debuffduration})
	end
end