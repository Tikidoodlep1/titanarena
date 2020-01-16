function gpmBoost(keys)
local caster = keys.caster
local ability = keys.ability
local target = keys.target
if keys.target:GetTeamNumber() == 4 then
	target:Kill(ability, caster)
	ability:ApplyDataDrivenModifier(caster, caster, "modifier_damage_pct", {duration=1.1})
	ability:ApplyDataDrivenModifier(caster, caster, "gpm", {duration=60})
	caster:AddExperience(target:GetDeathXP()*3, 2, false, true)
end
end

function goldGain(keys)
local caster = keys.caster
PlayerResource:ModifyGold(caster:GetPlayerID(), 5, true, 10)
end