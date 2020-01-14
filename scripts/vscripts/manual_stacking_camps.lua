function disable_spawning_radiant1(trigger)
_G.radiant1_stacking_can_spawn = false
print("Radiant 1 has creeps in it")
end

function enable_spawning_radiant1(trigger)
_G.radiant1_stacking_can_spawn = true
print("Radiant 1 is empty")
end

function enable_spawning_dire1(trigger)
_G.dire1_stacking_can_spawn = true
print("dire 1 is empty")
end

function disable_spawning_dire1(trigger)
_G.dire1_stacking_can_spawn = false
print("dire 1 has creeps in it")
end

function disable_spawning_radiant2(trigger)
_G.radiant2_stacking_can_spawn = false
print("radiant 2 has creeps in it")
end

function enable_spawning_radiant2(trigger)
_G.radiant2_stacking_can_spawn = true
print("radiant 2 is empty")
end

function enable_spawning_dire2(trigger)
_G.dire1_stacking_can_spawn = true
print("dire 2 is empty")
end

function disable_spawning_dire2(trigger)
_G.dire2_stacking_can_spawn = false
print("dire 2 has creeps in it")
end