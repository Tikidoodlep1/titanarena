function spawn_eidolons(keys)
local caster = keys.caster
local ability = keys.ability
local target = keys.target
local abil_level = keys.ability:GetLevel()
local eidolon_hp = ability:GetSpecialValueFor("eidolon_hp_tooltip")
local eidolon_damage = ability:GetSpecialValueFor("eidolon_dmg_tooltip")
local point = target:GetAbsOrigin()

target:Kill(ability, caster)

for i = 0, 2, 1 do
local unit = CreateUnitByName("npc_dota_eidolon", point, true, caster, caster, caster:GetTeamNumber())

unit:SetControllableByPlayer(caster:GetPlayerID(), false)

unit:SetMaxHealth(eidolon_hp)
unit:SetHealth(unit:GetMaxHealth())
unit:SetBaseDamageMax(eidolon_damage)
unit:SetBaseDamageMin(eidolon_damage - 5)
Timers:CreateTimer(40, function()

unit:ForceKill(false)

end)
end
end