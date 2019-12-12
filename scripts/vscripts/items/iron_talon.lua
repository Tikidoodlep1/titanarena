function BonusStats(keys)
local caster = keys.caster
local target = keys.target
local ability = keys.ability

	if caster:IsRangedAttacker() == false then
		ability:ApplyDataDrivenModifier(caster, caster, "iron_talon_stats_melee", {duration=-1})
	else
		ability:ApplyDataDrivenModifier(caster, caster, "iron_talon_stats_ranged", {duration=-1})
	end
end