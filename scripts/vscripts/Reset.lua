function CastReset(keys)
local caster = keys.caster
local casterID = caster:GetPlayerID()
local heroname = caster:GetUnitName()
local player = caster:GetPlayerOwner()
local level = PlayerResource:GetLevel(casterID)
local stackcount = caster:GetModifierStackCount("modifier_reset_bonus", caster)

	if level == 50 then
		local item1 = caster:GetItemInSlot(0)
		local item2 = caster:GetItemInSlot(1)
		local item3 = caster:GetItemInSlot(2)
		local item4 = caster:GetItemInSlot(3)
		local item5 = caster:GetItemInSlot(4)
		local item6 = caster:GetItemInSlot(5)
		local item7 = caster:GetItemInSlot(6)
		local item8 = caster:GetItemInSlot(7)
		local item9 = caster:GetItemInSlot(8)
		local item10 = caster:GetItemInSlot(9)
		local item11 = caster:GetItemInSlot(10)
		local item12 = caster:GetItemInSlot(11)
		local item13 = caster:GetItemInSlot(12)
		local item14 = caster:GetItemInSlot(13)
		local item15 = caster:GetItemInSlot(14)
		local item16 = caster:GetItemInSlot(15)
		
		local new_hero = CreateHeroForPlayer(heroname, player)
		new_hero:SetControllableByPlayer(casterID, true)
		player:SetAssignedHeroEntity(new_hero)
		
		for _,hero in ipairs(HeroList:GetAllHeroes()) do
			if new_hero:GetUnitName() == hero:GetUnitName() then
				if hero:GetTeamNumber() == 2 then
					FindClearSpaceForUnit(new_hero, Entities:FindByName(nil, "radiant_spawn"):GetAbsOrigin(), false)
				else
					FindClearSpaceForUnit(new_hero, Entities:FindByName(nil, "dire_spawn"):GetAbsOrigin(), false)
				end
			end
		end
		if item1 == nil then
		else
			new_hero:AddItemByName(item1:GetName())
		end
		if item2 == nil then
		else
			new_hero:AddItemByName(item2:GetName())
		end
		if item3 == nil then
		else
			new_hero:AddItemByName(item3:GetName())
		end
		if item4 == nil then
		else
			new_hero:AddItemByName(item4:GetName())
		end
		if item5 == nil then
		else
			new_hero:AddItemByName(item5:GetName())
		end
		if item6 == nil then
		else
			new_hero:AddItemByName(item6:GetName())
		end
		if item7 == nil then
		else
			new_hero:AddItemByName(item7:GetName())
		end
		if item8 == nil then
		else
			new_hero:AddItemByName(item8:GetName())
		end
		if item9 == nil then
		else
			new_hero:AddItemByName(item9:GetName())
		end
		if item10 == nil then
		else
			new_hero:AddItemByName(item10:GetName())
		end
		if item11 == nil then
		else
			new_hero:AddItemByName(item11:GetName())
		end
		if item12 == nil then
		else
			new_hero:AddItemByName(item12:GetName())
		end
		if item13 == nil then
		else
			new_hero:AddItemByName(item13:GetName())
		end
		if item14 == nil then
		else
			new_hero:AddItemByName(item14:GetName())
		end
		if item15 == nil then
		else
			new_hero:AddItemByName(item15:GetName())
		end
		if item16 == nil then
		else
			new_hero:AddItemByName(item16:GetName())
		end
		print("reset success")
		for _,hero in ipairs(HeroList:GetAllHeroes()) do
			if new_hero:GetUnitName() == hero:GetUnitName() then
				if new_hero:HasModifier("modifier_reset_bonus") == true then
					new_hero:SetModifierStackCount("modifier_reset_bonus", new_hero, stackcount + 1)
				else
					new_hero:AddNewModifier(new_hero, nil, "modifier_reset_bonus", {duration=-1})
					new_hero:SetModifierStackCount("modifier_reset_bonus", new_hero, stackcount + 1)
				end
			end
		end
	end
		
		for _,hero in ipairs(HeroList:GetAllHeroes()) do
			if hero:GetUnitName() == caster:GetUnitName() then
				new_hero =	hero
				hero:Destroy()
				break
			end
		end
		
		
end