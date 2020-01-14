function spawn_ward(keys)
local caster = keys.caster
local ability = keys.ability
local abil_level = keys.ability:GetLevel()
local ward_hp = ability:GetSpecialValueFor("ward_hp_tooltip")
local ward_damage = ability:GetSpecialValueFor("ward_damage_tooltip")
local point = caster:GetCursorPosition()
local unit = CreateUnitByName("npc_dota_venomancer_plague_ward_1", point, true, caster, caster, caster:GetTeamNumber())


unit:SetControllableByPlayer(caster:GetPlayerID(), false)

unit:SetMaxHealth(ward_hp)
unit:SetHealth(unit:GetMaxHealth())
unit:SetBaseDamageMax(ward_damage)
unit:SetBaseDamageMin(ward_damage - 5)
end