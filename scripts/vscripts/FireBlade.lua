
function ApplyBurn(keys)
local caster = keys.caster
local target = keys.target
local ability = keys.ability
local dur = ability:GetSpecialValueFor("burn_duration")
local damage = ability:GetSpecialValueFor("burn_pct")

ability:ApplyDatadrivenModifier(caster, target, "burn_damage", {duration = dur})

function ApplyDamage(keys)
local caster = keys.caster
local target = keys.target
local ability = keys.ability
local dam = ability:GetSpecialValueFor("burn_pct")
--should use ability:GetSpecialValueFor("burn_pct", ability:GetLevel() - 1), better syntax and better code conventions
local applieddamage = target:GetMaxHealth() * (dam / 100) * rate

	if target:HasModifier("burn_damage") then
		ApplyDamage({victim = target, attacker = caster, damage = applieddamage, damage_type = DAMAGE_TYPE_MAGICAL})
	end
end