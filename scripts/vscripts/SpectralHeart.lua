function ApplyHeal(keys)
local caster = keys.caster
local ability = keys.ability
local regen = ability:GetSpecialValueFor("regen_pct")
local mana_regen = ability:GetSpecialValueFor("mana_regen_pct")
local rate = ability:GetSpecialValueFor("rate")

	if ability:IsCooldownReady() and caster:IsRealHero() then
		caster:Heal(caster:GetMaxHealth() * (regen / 100) * rate, caster)
		caster:GiveMana(caster:GetMaxMana() * (mana_regen / 100) * rate)
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
local attacker = keys.attacker
local cd = ability:GetSpecialValueFor("cooldown")

	if attacker:IsHero() == true then
	ability:StartCooldown(cd)

		if caster:HasModifier("visible_regen_modifier") then
			caster:RemoveModifierByNameAndCaster("visible_regen_modifier", caster)
		end
	end
end

function OnDestroy(keys)
local caster = keys.caster

caster:RemoveModifierByNameAndCaster("visible_regen_modifier", caster)
end