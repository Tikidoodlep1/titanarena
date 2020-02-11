function spawn_treants(keys)
local caster = keys.caster
local team = caster:GetTeam()
local ability = keys.ability
local point = caster:GetCursorPosition()
local abil_range = ability:GetSpecialValueFor("area_of_effect")
local max_treants = ability:GetSpecialValueFor("max_treants")
local treants_spawned = 0
local treant_max_hp = ability:GetSpecialValueFor("treant_health_tooltip")
local treant_damage = ability:GetSpecialValueFor("treant_dmg_tooltip")
local bonus_hp = 1
local bonus_dmg = 1
local bonus_hp_talent = caster:FindAbilityByName("special_bonus_unique_furion")
local bonus_hp_talent_lvl = bonus_hp_talent:GetLevel()
local bonus_treants_spawned_talent = caster:FindAbilityByName("special_bonus_unique_furion_2")
local bonus_treants_spawned_level = bonus_treants_spawned_talent:GetLevel()
local bonus_treants_spawned = 0


if bonus_hp_talent_lvl == 1 then
bonus_hp = 2
bonus_dmg = 2
end

if bonus_treants_spawned_level == 1 then
bonus_treants_spawned = 4
end





local trees = GridNav:GetAllTreesAroundPoint(point, abil_range, false)
	for num,tree in pairs(trees) do
if treants_spawned < (max_treants+bonus_treants_spawned) then
local spawn_point = tree:GetAbsOrigin()
EmitSoundOnLocationWithCaster(point, "sounds/weapons/hero/furion/force_cast.vsnd", caster)
local unit = CreateUnitByName("npc_dota_furion_treant_1", spawn_point, true, caster, caster, team)
treants_spawned = treants_spawned + 1

unit:AddNewModifier(unit, nil, "modifier_kill", {duration = 60})
unit:SetMaxHealth((treant_max_hp*bonus_hp))
unit:SetHealth(unit:GetMaxHealth())
unit:SetBaseDamageMax(treant_damage*bonus_dmg)
unit:SetBaseDamageMin(treant_damage*bonus_dmg)
unit:SetControllableByPlayer(caster:GetPlayerID(), false)
unit.time = GameRules:GetGameTime()




end
tree:CutDown(-1)






	end


end