function Damage(keys)
local caster = keys.caster
local target = keys.target
local targetpos = target:GetAbsOrigin
local ability = keys.ability
local range = ability:GetSpecialValueFor("radius", ability:GetLevel() - 1)
local max_targets = ability:GetSpecialValueFor("targets", ability:GetLevel() - 1)
local targets_to_damage
local basedamagedifference = caster:GetBaseDamageMax() - caster:GetBaseDamageMin()
local basedamage = caster:GetBaseDamageMax() - basedamagedifference
local damagetodeal = basedamage/max_targets
local teamnum = caster:GetTeamNumber
local damageTable = {
	victim = targets_to_damage
	attacker = caster
	damage = damagetodeal
	damage_type = DAMAGE_TYPE_PHYSICAL
	ability = ability
}
	
local units = FindUnitsInRadius(teamnum,Vector(targetpos),nil,range,DOTA_UNIT_TARGET_TEAM_ENEMY,DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP + DOTA_UNIT_TARGET_MECHANICAL,DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NOT_NIGHTMARED,FIND_ANY_ORDER,false)
		
local x = 1
		for number,entity in pairs(units) do
			if x <= max_targets and entity:IsHero()
				entity:ApplyDamage(damageTable)
			else
				for number,entity in pairs(units) do
				if x <= max_targets
				entity:ApplyDamage(damageTable)
				end
			end
		end
		x=x+1
	end
end