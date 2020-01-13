function RevealUsed( keys )
	local targetUnit = keys.target_entities[1]
	local caster = keys.caster
	caster:GetTeam()
	local team = caster:GetTeam()
	local ability = keys.ability

if team == 2 then
	GameRules:SendCustomMessage("<font color='#008000'> Radiant </font> Has Used A Forseer's Flare to reveal a location on the map", 0, 0)end
if team == 3 then
	GameRules:SendCustomMessage("<font color='#ff0000'> Dire </font> Has Used A Forseer's Flare to reveal a location on the map", 0, 0)end

	for i = 0, 5 do
		local item = caster:GetItemInSlot(i)
		if item then
			if item:GetAbilityName() == 'item_forseers_flare' then
				if item:GetCurrentCharges() == 1 then
					UTIL_RemoveImmediate(item)
				else
					item:SetCurrentCharges(item:GetCurrentCharges() - 1)
				end
			end
		end
	end
end