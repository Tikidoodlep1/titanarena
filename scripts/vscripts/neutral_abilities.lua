function ManaBurn(keys)
local caster = keys.caster
local target = keys.target
local manaBurn = keys.ability:GetLevelSpecialValueFor("mana_break")
local manaDamage = keys.ability:GetLevelSpecialValueFor("damage_per_mana")

local damageTable = {}
damageTable.attacker = caster
damageTable.victim = target
damageTable.damage_type = keys.ability:GetAbilityDamageType()
damageTable.ability = ability

	if target:GetMana() >= manaBurn then
		damageTable.damage = manaBurn * manaDamage
		target:ReduceMana(manaBurn)
	else
		damageTable.damage = target:GetMana() * manaDamage
		target:ReduceMana(manaBurn)
	end

	ApplyDamage(damageTable)
end

function FrostAttack(keys)
local caster = keys.caster
local target = keys.target
local ability = keys.ability

target:ApplyDataDrivenModifier(caster, target, "ghost_frost_attack_modifier", {duration = 2})

end