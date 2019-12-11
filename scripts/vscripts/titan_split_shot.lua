function Damage(keys)
local caster = keys.caster
local target = keys.target
local targetpos = target:GetAbsOrigin()
local ability = keys.ability
local range = ability:GetSpecialValueFor("radius")
local max_targets = ability:GetSpecialValueFor("targets")
local basedamagedifference = caster:GetBaseDamageMax() - caster:GetBaseDamageMin()
local basedamage = caster:GetBaseDamageMax() - basedamagedifference
local damagetodeal = basedamage/max_targets
local teamnum = caster:GetTeamNumber()
local targets_to_damage
	
local units = FindUnitsInRadius(teamnum,targetpos,nil,range,DOTA_UNIT_TARGET_TEAM_ENEMY,DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP,DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NOT_NIGHTMARED,FIND_ANY_ORDER,false)
		
local x = 1
	for number,entity in pairs(units) do
		if x <= max_targets and entity:IsHero() then
		local damageTable = {
			victim = entity,
			attacker = caster,
			damage = damagetodeal,
			damage_type = DAMAGE_TYPE_PHYSICAL,
			}
			if teamnum == 2 then
				ParticleManager:CreateParticle("particles/econ/items/kunkka/divine_anchor/hero_kunkka_dafx_skills/kunkka_spell_torrent_splash_fxset.vpcf", PATTACH_ABSORIGIN_FOLLOW, entity)
			else
				ParticleManager:CreateParticle("particles/units/heroes/hero_necrolyte/necrolyte_scythe_start.vpcf", PATTACH_ABSORIGIN_FOLLOW, entity)
			end
			ApplyDamage(damageTable)
	x = x + 1
		end
	end
	if x <= max_targets then
	local y = max_targets - x
		for number,entity in pairs(units) do
			if y <= max_targets then
			local damageTable = {
				victim = entity,
				attacker = caster,
				damage = damagetodeal,
				damage_type = DAMAGE_TYPE_PHYSICAL,
				}
				if teamnum == 2 then
					ParticleManager:CreateParticle("particles/econ/items/kunkka/divine_anchor/hero_kunkka_dafx_skills/kunkka_spell_torrent_splash_fxset.vpcf", PATTACH_ABSORIGIN_FOLLOW, entity)
				else
					ParticleManager:CreateParticle("particles/units/heroes/hero_necrolyte/necrolyte_scythe_start.vpcf", PATTACH_ABSORIGIN_FOLLOW, entity)
				end
				ApplyDamage(damageTable)
				y = y + 1
			end
		end
	end
end