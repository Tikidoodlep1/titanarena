function Modifier(keys)
local caster = keys.caster
local point = keys.target
local ability = keys.ability
print(point:GetAbsOrigin())
local radius = ability:GetSpecialValueFor("radius")
local units = FindUnitsInRadius(caster:GetTeamNumber(), point:GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO, FIND_ANY_ORDER, false)
	for _, creep in pairs(units) do
		if creep:GetTeamNumber() == 4 then
			ability:ApplyDataDrivenModifier(caster, creep, "modifier_gold", {duration=4})
		end
	end
end

function BonusGold(keys)
local caster = keys.caster
local ability = keys.ability
local bonus = ability:GetSpecialValueFor("bonus_gold")
caster:ModifyGold(bonus, false, 13)
end