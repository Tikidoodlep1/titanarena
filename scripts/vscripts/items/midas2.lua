function gpmBoost(keys)
local caster = keys.caster
PlayerResource:ModifyGold(caster:GetPlayerID(), 3, true, 10)
if caster:HasItemInInventory("item_midas_2") and not caster:HasModifier("modifier_damage_pct") then
	keys.ability:ApplyDataDrivenModifier(caster, caster, "modifier_damage_pct", {duration=1.1})
end
end