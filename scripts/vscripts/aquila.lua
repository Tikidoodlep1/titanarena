function ApplyAura(keys)
local caster = keys.caster
local ability = keys.abilty
	if caster:HasModifier("apply_aquila_modifier") == false then
		ability:ApplyDataDrivenModifier(caster, caster, "apply_aquila_modifier", {duration = -1})
	else
		ability:RemoveModifierByNameAndCaster("apply_aquila_modifier", caster)
	end
end