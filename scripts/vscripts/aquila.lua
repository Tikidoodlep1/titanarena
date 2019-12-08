function ApplyAura(keys)
local caster = keys.caster
local ability = keys.abilty
	if caster:HasModifier("aquila_aura_modifier") == false then
		caster:ApplyDataDrivenModifier(caster, caster, "aquila_aura_modifier", {duration = -1})
	else
		caster:RemoveModifierByNameAndCaster("aquila_aura_modifier", caster)
	end
end