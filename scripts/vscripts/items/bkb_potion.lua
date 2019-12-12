function check_health(keys)
	local ability = _G.bkb_passive
	local current_health = caster:GetHealth() 
	local max_health = caster:GetMaxHealth()
	local hp_threshold = 35
	local magic_immune_duration = 5
	if ((current_health/max_health)*100) <= hp_threshold then
			caster:AddNewModifier(caster, caster, "modifier_magic_immune", {duration = 5})
			local particle = ParticleManager:CreateParticle("particles/items_fx/black_king_bar_avatar.vpcf", PATTACH_ABSORIGIN_FOLLOW, keys.caster)
			caster:RemoveModifierByName("modifier_item_bkb_potion_passive")
			caster:EmitSound("DOTA_Item.BlackKingBar.Activate")
			Timers:CreateTimer(magic_immune_duration, function()
	
	ParticleManager:DestroyParticle(particle, true)
		
	end)
	end
end


	function apply_passive(keys)
		caster = keys.caster
		_G.bkb_passive = keys.ability
		print(keys.ability)
		_G.bkb_passive:ApplyDataDrivenModifier(caster, caster, "modifier_item_bkb_potion_passive", {duration = -1})
		    for i = 0, 5 do
        local item = caster:GetItemInSlot(i)
        if item then
            if item:GetAbilityName() == 'item_bkb_potion' then
                if item:GetCurrentCharges() == 1 then
                    UTIL_RemoveImmediate(item)
                else
                    item:SetCurrentCharges(item:GetCurrentCharges() - 1)
                end
            end
        end
    end
	end