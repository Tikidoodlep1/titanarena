function ApplyCrit(keys)
local caster = keys.caster
local target = keys.target
local ability = keys.ability
local critchance = ability:GetSpecialValueFor("crit_chance")
local critdamage = ability:GetSpecialValueFor("crit_multiplier")
local random_int = RandomInt(1,100)

	if randon_int <= critchance then
		target:EmitSound("DOTA_Item.Greater_Crit")
		ability:ApplyDataDrivenModifier(caster, caster, "crit_hit", {duration = -1})
		if caster:OnAttackFinished then
			caster:RemoveModifierByName("crit_hit")
		end
	end
end