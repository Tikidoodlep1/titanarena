function warp_check(trigger)
local unit = trigger.activator

if unit:GetUnitName() == "npc_boss_wanderer" then 
local point = Entities:FindByName(nil, "wanderer_spawn"):GetAbsOrigin()
FindClearSpaceForUnit(unit, point, false)
print("Wanderer has crossed the trigger, and has been teleported back to its spawn point!")

else
print("wanderer not found")
end
end