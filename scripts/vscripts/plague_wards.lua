function spawn_ward(keys)
local caster = keys.caster
local ability = keys.ability
local abil_level = keys.ability:GetLevel()
local ward_hp = ability:GetSpecialValueFor("ward_hp_tooltip")
local ward_damage = ability:GetSpecialValueFor("ward_damage_tooltip")
local talent = caster:FindAbilityByName("special_bonus_unique_venomancer")
local talentlvl = talent:GetLevel()
local bonus = 1
local point = caster:GetCursorPosition()
local unit = CreateUnitByName("npc_dota_venomancer_plague_ward_1", point, true, caster, caster, caster:GetTeamNumber())
EmitSoundOnLocationWithCaster(point, "Hero_Venomancer.Plague_Ward", caster)
if talentlvl == 1 then
bonus = 3
end
unit:SetControllableByPlayer(caster:GetPlayerID(), false)

unit:SetMaxHealth(ward_hp*bonus)
unit:SetHealth(unit:GetMaxHealth())
unit:SetBaseDamageMax(ward_damage*bonus)
unit:SetBaseDamageMin(ward_damage*bonus)
Timers:CreateTimer(40, function()

unit:ForceKill(false)

end)
end