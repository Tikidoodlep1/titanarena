function BonusStats(keys)
local caster = keys.caster
local target = keys.target
local ability = keys.ability
local damage_pct = ability:GetSpecialValueFor("creep_damage_pct")
local ranged = caster:IsRangedAttacker()

if ranged == false then
ApplyDataDrivenModifier(caster, caster, "iron_talon_stats_melee", {duration=-1})
elseif ranged = true then
ApplyDataDrivenModifier(caster, caster, "iron_talon_stats_ranged", {duration=-1})
end
end