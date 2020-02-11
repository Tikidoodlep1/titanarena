function swap_to_item(keys, ItemName)
	for i=0, 5, 1 do  --Fill all empty slots in the player's inventory with "dummy" items.
		local current_item = keys.caster:GetItemInSlot(i)
		if current_item == nil then
			keys.caster:AddItem(CreateItem("item_dummy_datadriven", keys.caster, keys.caster))
		end
	end
	
	keys.caster:RemoveItem(keys.ability)
	keys.caster:AddItem(CreateItem(ItemName, keys.caster, keys.caster))  --This should be put into the same slot that the removed item was in.
	
	for i=0, 5, 1 do  --Remove all dummy items from the player's inventory.
		local current_item = keys.caster:GetItemInSlot(i)
		if current_item ~= nil then
			if current_item:GetName() == "item_dummy_datadriven" then
				keys.caster:RemoveItem(current_item)
			end
		end
	end
end


--[[ ============================================================================================================
	Author: Rook
	Date: February 5, 2015
	Called when Ring of Aquila (active) is cast.  Toggles the item to an inactive state.
================================================================================================================= ]]
function item_moms_ring_on_spell_start(keys)
	swap_to_item(keys, "item_moms_ring_inactive")
end


--[[ ============================================================================================================
	Author: Rook
	Date: February 5, 2015
	Called when Ring of Aquila (inactive) is cast.  Toggles the item to an active state.
================================================================================================================= ]]
function item_moms_ring_inactive_on_spell_start(keys)
	swap_to_item(keys, "item_moms_ring_active")
end