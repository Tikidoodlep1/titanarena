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

end

function disable_spawning_radiant3(trigger)
_G.radiant3_stacking_can_spawn = false

end

function enable_spawning_radiant3(trigger)
_G.radiant3_stacking_can_spawn = true

end

function disable_spawning_radiant4(trigger)
_G.radiant4_stacking_can_spawn = false

end

function enable_spawning_radiant4(trigger)
_G.radiant4_stacking_can_spawn = true

end

function disable_spawning_radiant5(trigger)
_G.radiant5_stacking_can_spawn = false

end

function enable_spawning_radiant5(trigger)
_G.radiant5_stacking_can_spawn = true

end

function disable_spawning_radiant6(trigger)
_G.radiant6_stacking_can_spawn = false

end

function enable_spawning_radiant6(trigger)
_G.radiant6_stacking_can_spawn = true

end

function enable_spawning_radiant7(trigger)
_G.radiant7_stacking_can_spawn = true

end

function disable_spawning_radiant7(trigger)
_G.radiant7_stacking_can_spawn = false

end

function enable_spawning_radiant8(trigger)
_G.radiant8_stacking_can_spawn = true

end

function disable_spawning_radiant8(trigger)
_G.radiant8_stacking_can_spawn = false

end

function enable_spawning_radiant9(trigger)
_G.radiant9_stacking_can_spawn = true

end

function disable_spawning_radiant9(trigger)
_G.radiant9_stacking_can_spawn = false

end

function enable_spawning_dire2(trigger)
_G.dire2_stacking_can_spawn = true

end

function disable_spawning_dire2(trigger)
_G.dire2_stacking_can_spawn = false

end

function enable_spawning_dire3(trigger)
_G.dire3_stacking_can_spawn = true

end

function disable_spawning_dire3(trigger)
_G.dire3_stacking_can_spawn = false

end

function enable_spawning_dire4(trigger)
_G.dire4_stacking_can_spawn = true

end

function disable_spawning_dire4(trigger)
_G.dire4_stacking_can_spawn = false

end

function enable_spawning_dire5(trigger)
_G.dire5_stacking_can_spawn = true

end

function disable_spawning_dire5(trigger)
_G.dire5_stacking_can_spawn = false

end

function enable_spawning_dire6(trigger)
_G.dire6_stacking_can_spawn = true

end

function disable_spawning_dire6(trigger)
_G.dire6_stacking_can_spawn = false

end

function enable_spawning_dire7(trigger)
_G.dire7_stacking_can_spawn = true

end

function disable_spawning_dire7(trigger)
_G.dire7_stacking_can_spawn = false

end

function enable_spawning_dire8(trigger)
_G.dire8_stacking_can_spawn = true

end

function disable_spawning_dire8(trigger)
_G.dire8_stacking_can_spawn = false

end

function enable_spawning_dire9(trigger)
_G.dire9_stacking_can_spawn = true

end

function disable_spawning_dire9(trigger)
_G.dire9_stacking_can_spawn = false

end

function radiant_easy1_camp_add(trigger)
	if trigger.activator:IsHero() == true then 
		_G.radiant_easy1_canspawn = false
	end
	_G.radiant_easy1_creeps = _G.radiant_easy1_creeps + 1

end

function radiant_easy1_camp_minus(trigger)
	if trigger.activator:IsHero() == true then 
		_G.radiant_easy1_canspawn = true
	end
_G.radiant_easy1_creeps = _G.radiant_easy1_creeps - 1
end

function radiant_easy2_camp_add(trigger)
	if trigger.activator:IsHero() == true then 
		_G.radiant_easy2_canspawn = false
	end
_G.radiant_easy2_creeps = _G.radiant_easy2_creeps + 1
end

function radiant_easy2_camp_minus(trigger)
	if trigger.activator:IsHero() == true then 
		_G.radiant_easy2_canspawn = true
	end
_G.radiant_easy2_creeps = _G.radiant_easy2_creeps - 1
end

function radiant_easy3_camp_add(trigger)
		if trigger.activator:IsHero() == true then 
		_G.radiant_easy3_canspawn = false
	end
_G.radiant_easy3_creeps = _G.radiant_easy3_creeps + 1
end

function radiant_easy3_camp_minus(trigger)
		if trigger.activator:IsHero() == true then 
		_G.radiant_easy3_canspawn = true
	end
_G.radiant_easy3_creeps = _G.radiant_easy3_creeps - 1
end

function radiant_medium1_camp_add(trigger)
		if trigger.activator:IsHero() == true then 
		_G.radiant_medium1_canspawn = false
	end
_G.radiant_medium1_creeps = _G.radiant_medium1_creeps + 1
end

function radiant_medium1_camp_minus(trigger)
		if trigger.activator:IsHero() == true then 
		_G.radiant_medium1_canspawn = true
	end
_G.radiant_medium1_creeps = _G.radiant_medium1_creeps - 1
end

function radiant_medium2_camp_add(trigger)
		if trigger.activator:IsHero() == true then 
		_G.radiant_medium2_canspawn = false
	end
_G.radiant_medium2_creeps = _G.radiant_medium2_creeps + 1
end

function radiant_medium2_camp_minus(trigger)
			if trigger.activator:IsHero() == true then 
		_G.radiant_medium2_canspawn = true
	end
_G.radiant_medium2_creeps = _G.radiant_medium2_creeps - 1
end

function radiant_medium3_camp_add(trigger)
			if trigger.activator:IsHero() == true then 
		_G.radiant_medium2_canspawn = false
	end
_G.radiant_medium3_creeps = _G.radiant_medium3_creeps + 1
end

function radiant_medium3_camp_minus(trigger)
			if trigger.activator:IsHero() == true then 
		_G.radiant_medium3_canspawn = true
	end
_G.radiant_medium3_creeps = _G.radiant_medium3_creeps - 1
end

function radiant_medium4_camp_add(trigger)
			if trigger.activator:IsHero() == true then 
		_G.radiant_medium4_canspawn = false
	end
_G.radiant_medium4_creeps = _G.radiant_medium4_creeps + 1
end

function radiant_medium4_camp_minus(trigger)
			if trigger.activator:IsHero() == true then 
		_G.radiant_medium4_canspawn = true
	end
_G.radiant_medium4_creeps = _G.radiant_medium4_creeps - 1
end

function radiant_hard1_camp_add(trigger)
			if trigger.activator:IsHero() == true then 
		_G.radiant_hard1_canspawn = false
	end
_G.radiant_hard1_creeps = _G.radiant_hard1_creeps + 1
end

function radiant_hard1_camp_minus(trigger)
	if trigger.activator:IsHero() == true then 
		_G.radiant_hard1_canspawn = true
	end
_G.radiant_hard1_creeps = _G.radiant_hard1_creeps - 1
end

function radiant_hard2_camp_add(trigger)
	if trigger.activator:IsHero() == true then 
		_G.radiant_hard2_canspawn = false
	end
_G.radiant_hard2_creeps = _G.radiant_hard2_creeps + 1
end

function radiant_hard2_camp_minus(trigger)
	if trigger.activator:IsHero() == true then 
		_G.radiant_hard2_canspawn = true
	end
_G.radiant_hard2_creeps = _G.radiant_hard2_creeps - 1
end

function radiant_hard3_camp_add(trigger)
	if trigger.activator:IsHero() == true then 
		_G.radiant_hard3_canspawn = false
	end
_G.radiant_hard3_creeps = _G.radiant_hard3_creeps + 1
end

function radiant_hard3_camp_minus(trigger)
	if trigger.activator:IsHero() == true then 
		_G.radiant_hard3_canspawn = true
	end
_G.radiant_hard3_creeps = _G.radiant_hard3_creeps - 1
end

function radiant_hard4_camp_add(trigger)
	if trigger.activator:IsHero() == true then 
		_G.radiant_hard4_canspawn = false
	end
_G.radiant_hard4_creeps = _G.radiant_hard4_creeps + 1
end

function radiant_hard4_camp_minus(trigger)
	if trigger.activator:IsHero() == true then 
		_G.radiant_hard4_canspawn = true
	end
_G.radiant_hard4_creeps = _G.radiant_hard4_creeps - 1
end

function radiant_ancient1_camp_add(trigger)
	if trigger.activator:IsHero() == true then 
		_G.radiant_ancient1_canspawn = false
	end
_G.radiant_ancient1_creeps = _G.radiant_ancient1_creeps + 1
end

function radiant_ancient1_camp_minus(trigger)
		if trigger.activator:IsHero() == true then 
		_G.radiant_ancient1_canspawn = true
	end
_G.radiant_ancient1_creeps = _G.radiant_ancient1_creeps - 1
end

function radiant_ancient2_camp_add(trigger)
		if trigger.activator:IsHero() == true then 
		_G.radiant_ancient2_canspawn = false
	end
_G.radiant_ancient2_creeps = _G.radiant_ancient2_creeps + 1
end

function radiant_ancient2_camp_minus(trigger)
		if trigger.activator:IsHero() == true then 
		_G.radiant_ancient2_canspawn = true
	end
_G.radiant_ancient2_creeps = _G.radiant_ancient2_creeps - 1
end

function dire_easy1_camp_add(trigger)
		if trigger.activator:IsHero() == true then 
		_G.dire_easy1_canspawn = false
	end
_G.dire_easy1_creeps = _G.dire_easy1_creeps + 1
print("camp 1 has ".. _G.dire_easy1_creeps)
end

function dire_easy1_camp_minus(trigger)
			if trigger.activator:IsHero() == true then 
		_G.dire_easy1_canspawn = true
	end
_G.dire_easy1_creeps = _G.dire_easy1_creeps - 1
print("camp 1 has ".. _G.dire_easy1_creeps)
end

function dire_easy2_camp_add(trigger)
			if trigger.activator:IsHero() == true then 
		_G.dire_easy2_canspawn = false
	end
_G.dire_easy2_creeps = _G.dire_easy2_creeps + 1
print("camp 2 has ".. _G.dire_easy2_creeps)
end

function dire_easy2_camp_minus(trigger)
			if trigger.activator:IsHero() == true then 
		_G.dire_easy2_canspawn = true
	end
_G.dire_easy2_creeps = _G.dire_easy2_creeps - 1
print("camp 2 has ".. _G.dire_easy2_creeps)
end

function dire_easy3_camp_add(trigger)
			if trigger.activator:IsHero() == true then 
		_G.dire_easy3_canspawn = false
	end
_G.dire_easy3_creeps = _G.dire_easy3_creeps + 1
end

function dire_easy3_camp_minus(trigger)
			if trigger.activator:IsHero() == true then 
		_G.dire_easy3_canspawn = true
	end
_G.dire_easy3_creeps = _G.dire_easy3_creeps - 1
end

function dire_medium1_camp_add(trigger)
			if trigger.activator:IsHero() == true then 
		_G.dire_medium1_canspawn = false
	end
_G.dire_medium1_creeps = _G.dire_medium1_creeps + 1
end

function dire_medium1_camp_minus(trigger)
	if trigger.activator:IsHero() == true then 
		_G.dire_medium1_canspawn = true
	end
_G.dire_medium1_creeps = _G.dire_medium1_creeps - 1
end

function dire_medium2_camp_add(trigger)
	if trigger.activator:IsHero() == true then 
		_G.dire_medium2_canspawn = false
	end
_G.dire_medium2_creeps = _G.dire_medium2_creeps + 1
end

function dire_medium2_camp_minus(trigger)
	if trigger.activator:IsHero() == true then 
		_G.dire_medium2_canspawn = true
	end
_G.dire_medium2_creeps = _G.dire_medium2_creeps - 1
end

function dire_medium3_camp_add(trigger)
	if trigger.activator:IsHero() == true then 
		_G.dire_medium3_canspawn = false
	end
_G.dire_medium3_creeps = _G.dire_medium3_creeps + 1
end

function dire_medium3_camp_minus(trigger)
	if trigger.activator:IsHero() == true then 
		_G.dire_medium3_canspawn = true
	end
_G.dire_medium3_creeps = _G.dire_medium3_creeps - 1
end

function dire_medium4_camp_add(trigger)
	if trigger.activator:IsHero() == true then 
		_G.dire_medium4_canspawn = false
	end
_G.dire_medium4_creeps = _G.dire_medium4_creeps + 1
end

function dire_medium4_camp_minus(trigger)
	if trigger.activator:IsHero() == true then 
		_G.dire_medium4_canspawn = true
	end
_G.dire_medium4_creeps = _G.dire_medium4_creeps - 1
end

function dire_hard1_camp_add(trigger)
	if trigger.activator:IsHero() == true then 
		_G.dire_hard1_canspawn = false
	end
_G.dire_hard1_creeps = _G.dire_hard1_creeps + 1

end

function dire_hard1_camp_minus(trigger)
	if trigger.activator:IsHero() == true then 
		_G.dire_hard1_canspawn = true
	end
_G.dire_hard1_creeps = _G.dire_hard1_creeps - 1

end

function dire_hard2_camp_add(trigger)
	if trigger.activator:IsHero() == true then 
		_G.dire_hard2_canspawn = false
	end
_G.dire_hard2_creeps = _G.dire_hard2_creeps + 1

end

function dire_hard2_camp_minus(trigger)
	if trigger.activator:IsHero() == true then 
		_G.dire_hard2_canspawn = true
	end
_G.dire_hard2_creeps = _G.dire_hard2_creeps - 1

end

function dire_hard3_camp_add(trigger)
	if trigger.activator:IsHero() == true then 
		_G.dire_hard3_canspawn = false
	end
_G.dire_hard3_creeps = _G.dire_hard3_creeps + 1
end

function dire_hard3_camp_minus(trigger)
	if trigger.activator:IsHero() == true then 
		_G.dire_hard3_canspawn = true
	end
_G.dire_hard3_creeps = _G.dire_hard3_creeps - 1
end

function dire_hard4_camp_add(trigger)
	if trigger.activator:IsHero() == true then 
		_G.dire_hard4_canspawn = false
	end
_G.dire_hard4_creeps = _G.dire_hard4_creeps + 1
end

function dire_hard4_camp_minus(trigger)
	if trigger.activator:IsHero() == true then 
		_G.dire_hard4_canspawn = true
	end
_G.dire_hard4_creeps = _G.dire_hard4_creeps - 1
end

function dire_ancient1_camp_add(trigger)
	if trigger.activator:IsHero() == true then 
		_G.dire_ancient1_canspawn = false
	end
_G.dire_ancient1_creeps = _G.dire_ancient1_creeps + 1

end

function dire_ancient1_camp_minus(trigger)
	if trigger.activator:IsHero() == true then 
		_G.dire_ancient1_canspawn = true
	end
_G.dire_ancient1_creeps = _G.dire_ancient1_creeps - 1

end

function dire_ancient2_camp_add(trigger)
	if trigger.activator:IsHero() == true then 
		_G.dire_ancient2_canspawn = false
	end
_G.dire_ancient2_creeps = _G.dire_ancient2_creeps + 1

end

function dire_ancient2_camp_minus(trigger)
	if trigger.activator:IsHero() == true then 
		_G.dire_ancient2_canspawn = true
	end
_G.dire_ancient2_creeps = _G.dire_ancient2_creeps - 1

end