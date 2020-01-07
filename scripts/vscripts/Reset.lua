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
		
		
		
		for _,hero in ipairs(HeroList:GetAllHeroes()) do
			if hero:GetUnitName() == caster:GetUnitName() then
				_G.resetherosname =	hero
				hero:Destroy()
				print("Destroyed old hero")
				break
			end
		end
		
		CreateHeroForPlayer(heroname, player):SetControllableByPlayer(casterID, false)
		
		for _,hero in ipairs(HeroList:GetAllHeroes()) do
			if PlayerResource:GetLevel(hero:GetPlayerID()) == 1 or PlayerResource:GetLevel(hero:GetPlayerID()) == 2 then
				print(hero:GetTeamNumber())
				if hero:GetTeamNumber() == 2 then
					FindClearSpaceForUnit(_G.resetherosname, Entities:FindByName(nil, "radiant_spawn"):GetAbsOrigin(), false)
					print("moved to spawn")
				else
					FindClearSpaceForUnit(_G.resetherosname, Entities:FindByName(nil, "dire_spawn"):GetAbsOrigin(), false)
					print("moved to spawn")
				end
			end
		end
		
		CreateItem(tostring(item1), _G.resetherosname, _G.resetherosname)
		CreateItem(tostring(item2), _G.resetherosname, _G.resetherosname)
		CreateItem(tostring(item3), _G.resetherosname, _G.resetherosname)
		CreateItem(tostring(item4), _G.resetherosname, _G.resetherosname)
		CreateItem(tostring(item5), _G.resetherosname, _G.resetherosname)
		CreateItem(tostring(item6), _G.resetherosname, _G.resetherosname)
		CreateItem(tostring(item7), _G.resetherosname, _G.resetherosname)
		CreateItem(tostring(item8), _G.resetherosname, _G.resetherosname)
		CreateItem(tostring(item9), _G.resetherosname, _G.resetherosname)
		CreateItem(tostring(item10), _G.resetherosname, _G.resetherosname)
		CreateItem(tostring(item11), _G.resetherosname, _G.resetherosname)
		CreateItem(tostring(item12), _G.resetherosname, _G.resetherosname)
		CreateItem(tostring(item13), _G.resetherosname, _G.resetherosname)
		CreateItem(tostring(item14), _G.resetherosname, _G.resetherosname)
		CreateItem(tostring(item15), _G.resetherosname, _G.resetherosname)
		CreateItem(tostring(item16), _G.resetherosname, _G.resetherosname)
		print("reset success")
		print(tostring(item1))
		for _,hero in ipairs(HeroList:GetAllHeroes()) do
			if _G.resetherosname == hero then
				if _G.resetherosname:HasModifier("modifier_reset_bonus") == true then
					SetModifierStackCount("modifier_reset_bonus", _G.resetherosname, stackcount + 1)
				else
					_G.resetherosname:AddNewModifier(_G.resetherosname, nil, "modifier_reset_bonus", {duration=-1})
					SetModifierStackCount("modifier_reset_bonus", _G.resetherosname, stackcount + 1)
				end
			end
		end
	end
end