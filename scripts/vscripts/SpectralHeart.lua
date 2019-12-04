function ApplyHeal(keys)
local caster = keys.caster
local ability = keys.ability
local regen = ability:GetSpecialValueFor("regen_pct")
local mana_regen = ability:GetSpecialValueFor("mana_regen_pct")
local rate = ability:GetSpecialValueFor("rate")

	if ability:IsCooldownReady() and caster:IsRealHero() then
		caster:Heal(caster:GetMaxHealth() * (regen / 100) * rate, caster)
			if not caster:HasModifier("visible_regen_modifier") then
				ability:ApplyDataDrivenModifier(caster, caster, "visible_regen_modifier", {duration = -1})
			end
	elseif caster:HasModifier("visible_regen_modifier") then
		caster:RemoveModifierByNameAndCaster("visible_regen_modifier", caster)
	end
end

function OnDamage(keys)
local caster = keys.caster
local ability = keys.ability
local cd = ability:GetSpecialValueFor("cooldown")

ability:StartCooldown(cd)

	if caster:HasModifier("visible_regen_modifier") then
		caster:RemoveModifierByNameAndCaster("visible_regen_modifier", caster)
	end
end

function OnDestroy(keys)
local caster = keys.caster

caster:RemoveModifierByNameAndCaster("visible_regen_modifier", caster)