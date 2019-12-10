function CheckRanged(keys)
local caster = keys.caster
local ability = keys.ability

	if caster:IsRangedAttacker() == true then
		ability:ApplyDataDrivenModifier(caster, caster, "ranged_modifier", {duration = -1})
	end
end