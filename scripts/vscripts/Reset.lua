require('gamemode')
function CastReset(keys)
local caster = keys.caster
local casterID = caster:GetPlayerID()
local heroname = caster:GetUnitName()
local player = caster:GetPlayerOwner()
local level = PlayerResource:GetLevel(casterID)
local stackcount = caster:GetModifierStackCount("modifier_reset_bonus", caster)
local item1_charges = 0
local item2_charges = 0
local item3_charges = 0
local item4_charges = 0
local item5_charges = 0
local item6_charges = 0
local item7_charges = 0
local item8_charges = 0
local item9_charges = 0
local item10_charges = 0
local item11_charges = 0
local item12_charges = 0
local item13_charges = 0
local item14_charges = 0
local item15_charges = 0
local item16_charges = 0

	if level == 50 then
		local item1 = caster:GetItemInSlot(0)
		if item1 ~= nil then
		local item1_charges = item1:GetCurrentCharges()
		end	
		
		local item2 = caster:GetItemInSlot(1)
		if item2 ~= nil then
		local item2_charges = item2:GetCurrentCharges()
		end	

		local item3 = caster:GetItemInSlot(2)
		if item3 ~= nil then
		local item3_charges = item3:GetCurrentCharges()
		end	
		local item4 = caster:GetItemInSlot(3)
		if item4 ~= nil then
		local item4_charges = item4:GetCurrentCharges()
		end		
		local item5 = caster:GetItemInSlot(4)
		if item5 ~= nil then
		local item5_charges = item5:GetCurrentCharges()
		end	
		local item6 = caster:GetItemInSlot(5)
		if item6 ~= nil then
		local item6_charges = item6:GetCurrentCharges()
		end	
		local item7 = caster:GetItemInSlot(6)
		if item7 ~= nil then
		local item7_charges = item7:GetCurrentCharges()
		end	
		local item8 = caster:GetItemInSlot(7)
		if item8 ~= nil then
		local item8_charges = item8:GetCurrentCharges()
		end	
		local item9 = caster:GetItemInSlot(8)
		if item9 ~= nil then
		local item9_charges = item9:GetCurrentCharges()
		end	
		local item10 = caster:GetItemInSlot(9)
		if item10 ~= nil then
		local item10_charges = item10:GetCurrentCharges()
		end	
		local item11 = caster:GetItemInSlot(10)
		if item11 ~= nil then
		local item11_charges = item11:GetCurrentCharges()
		end	
		local item12 = caster:GetItemInSlot(11)
		if item12 ~= nil then
		local item12_charges = item12:GetCurrentCharges()
		end	
		local item13 = caster:GetItemInSlot(12)
		if item13 ~= nil then
		local item13_charges = item13:GetCurrentCharges()
		end	
		local item14 = caster:GetItemInSlot(13)
		if item14 ~= nil then
		local item14_charges = item14:GetCurrentCharges()
		end	
		local item15 = caster:GetItemInSlot(14)
		if item15 ~= nil then
		local item15_charges = item15:GetCurrentCharges()
		end	
		local item16 = caster:GetItemInSlot(15)
		if item16 ~= nil then
		local item16_charges = item16:GetCurrentCharges()
		end	
		
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
			new_hero:AddItemByName(item1:GetName()):SetCurrentCharges(item1_charges)
		end
		if item2 == nil then
		else
			new_hero:AddItemByName(item2:GetName()):SetCurrentCharges(item2_charges)
		end
		if item3 == nil then
		else
			new_hero:AddItemByName(item3:GetName()):SetCurrentCharges(item3_charges)
		end
		if item4 == nil then
		else
			new_hero:AddItemByName(item4:GetName()):SetCurrentCharges(item4_charges)
		end
		if item5 == nil then
		else
			new_hero:AddItemByName(item5:GetName()):SetCurrentCharges(item5_charges)
		end
		if item6 == nil then
		else
			new_hero:AddItemByName(item6:GetName()):SetCurrentCharges(item6_charges)
		end
		if item7 == nil then
		else
			new_hero:AddItemByName(item7:GetName()):SetCurrentCharges(item7_charges)
		end
		if item8 == nil then
		else
			new_hero:AddItemByName(item8:GetName()):SetCurrentCharges(item8_charges)
		end
		if item9 == nil then
		else
			new_hero:AddItemByName(item9:GetName()):SetCurrentCharges(item9_charges)
		end
		if item10 == nil then
		else
			new_hero:AddItemByName(item10:GetName()):SetCurrentCharges(item10_charges)
		end
		if item11 == nil then
		else
			new_hero:AddItemByName(item11:GetName()):SetCurrentCharges(item11_charges)
		end
		if item12 == nil then
		else
			new_hero:AddItemByName(item12:GetName()):SetCurrentCharges(item12_charges)
		end
		if item13 == nil then
		else
			new_hero:AddItemByName(item13:GetName()):SetCurrentCharges(item13_charges)
		end
		if item14 == nil then
		else
			new_hero:AddItemByName(item14:GetName()):SetCurrentCharges(item14_charges)
		end
		if item15 == nil then
		else
			new_hero:AddItemByName(item15:GetName()):SetCurrentCharges(item15_charges)
		end
		if item16 == nil then
		else
			new_hero:AddItemByName(item16:GetName()):SetCurrentCharges(item16_charges)
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
		if level == 50 then
		EmitSoundOnClient("Item.MoonShard.Consume", player)
		for _,hero in ipairs(HeroList:GetAllHeroes()) do
			if hero:GetUnitName() == caster:GetUnitName() then
				new_hero =	hero
				hero:Destroy()
				break
			end
		end
	end
		if level ~= 50 or _G.IsDual == true then
			EmitSoundOnClient("General.InvalidTarget_Invulnerable", player)
			 Notifications:Bottom(player, {text="Must Be Level 50 To Use", duration=5, style={color="red", ["font-size"]="80px", border="10px solid red"}})
			caster:AddItemByName("item_reset"):SetCurrentCharges(1)
		end		
		
		
end