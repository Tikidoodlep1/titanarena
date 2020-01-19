function Add_Titan_HP(keys)
	local ability = keys.ability
	local caster  = keys.caster
	local hp_increase = ability:GetSpecialValueFor("bonus_health")
	if caster:GetTeamNumber() == 2 then
local Creatures = Entities:FindAllByClassname("npc_dota_creature")
	for _, unit in ipairs(Creatures) do
		if unit:GetUnitName() == "npc_radiant_titan" then
				unit:SetMaxHealth(unit:GetMaxHealth() + hp_increase)
				for i = 0, 5 do
		local item = caster:GetItemInSlot(i)
		if item then
			if item:GetName() == 'item_titan_hp_tome' then

					UTIL_RemoveImmediate(item)
			end
		end
	end
	end
	end
end
		if caster:GetTeamNumber() == 3 then
local Creatures = Entities:FindAllByClassname("npc_dota_creature")
	for _, unit in ipairs(Creatures) do
		if unit:GetUnitName() == "npc_dire_titan" then
				unit:SetMaxHealth(unit:GetMaxHealth() + hp_increase)
				for i = 0, 5 do
		local item = caster:GetItemInSlot(i)
		if item then
			if item:GetName() == 'item_titan_hp_tome' then

					UTIL_RemoveImmediate(item)
			end
		end
	end
	end
	end
end
end


function Add_Titan_Damage(keys)
	local ability = keys.ability
	local caster  = keys.caster
	local damage_increase = ability:GetSpecialValueFor("bonus_damage")
		if caster:GetTeamNumber() == 2 then
local Creatures = Entities:FindAllByClassname("npc_dota_creature")
	for _, unit in ipairs(Creatures) do
		if unit:GetUnitName() == "npc_radiant_titan" then
				unit:SetBaseDamageMax(unit:GetBaseDamageMax() + damage_increase)
				unit:SetBaseDamageMin(unit:GetBaseDamageMin() + damage_increase)
				for i = 0, 5 do
		local item = caster:GetItemInSlot(i)
		if item then
			if item:GetName() == 'item_titan_damage_tome' then
					UTIL_RemoveImmediate(item)
			end
		end
	end
	end
	end
end
		if caster:GetTeamNumber() == 3 then
local Creatures = Entities:FindAllByClassname("npc_dota_creature")
	for _, unit in ipairs(Creatures) do
		if unit:GetUnitName() == "npc_dire_titan" then
				unit:SetBaseDamageMax(unit:GetBaseDamageMax() + damage_increase)
				unit:SetBaseDamageMin(unit:GetBaseDamageMin() + damage_increase)
				for i = 0, 5 do
		local item = caster:GetItemInSlot(i)
		if item then
			if item:GetName() == 'item_titan_damage_tome' then
					UTIL_RemoveImmediate(item)
					return
			end
		end
	end
	end
	end
end
end

function Add_Titan_Armor(keys)
	local ability = keys.ability
	local caster  = keys.caster
	local armor_increase = ability:GetSpecialValueFor("bonus_armor")
		if caster:GetTeamNumber() == 2 then
local Creatures = Entities:FindAllByClassname("npc_dota_creature")
	for _, unit in ipairs(Creatures) do
		if unit:GetUnitName() == "npc_radiant_titan" then
				unit:SetPhysicalArmorBaseValue(unit:GetPhysicalArmorBaseValue() + armor_increase)
				for i = 0, 5 do
		local item = caster:GetItemInSlot(i)
		if item then
			if item:GetName() == 'item_titan_armor_tome' then
					UTIL_RemoveImmediate(item)
			end
		end
	end
	end
	end
end
		if caster:GetTeamNumber() == 3 then
local Creatures = Entities:FindAllByClassname("npc_dota_creature")
	for _, unit in ipairs(Creatures) do
		if unit:GetUnitName() == "npc_dire_titan" then
				unit:SetPhysicalArmorBaseValue(unit:GetPhysicalArmorBaseValue() + armor_increase)
				for i = 0, 5 do
		local item = caster:GetItemInSlot(i)
		if item then
			if item:GetName() == 'item_titan_armor_tome' then
					UTIL_RemoveImmediate(item)
					return
			end
		end
	end
	end
	end
end
end