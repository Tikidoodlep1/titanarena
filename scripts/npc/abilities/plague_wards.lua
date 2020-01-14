function spawn_ward(keys)
local caster = keys.caster
local ability = keys.ability
local abil_level = keys.ability:GetLevel()
local point = keys.target


local unit = CreateUnitByName("npc_dota_venomancer_plague_ward_1", point, true, caster, caster, caster:GetTeam())




end