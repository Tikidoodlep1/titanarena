require('gamemode')
function Spawn( entityKeyValues )


	thisEntity:SetContextThink( "dual_actions", dual_actions , 1)
	print("Starting AI for "..thisEntity:GetUnitName().." "..thisEntity:GetEntityIndex())

end

function dual_actions()

	-- Sets up a simple boss roaming mechanic

	if _G.IsDual == true and thisEntity:GetTeamNumber() == 2 then
		thisEntity:MoveToTargetToAttack(Entities:FindByName(nil, "npc_dire_titan"))
		thisEntity:SetAggroTarget(Entities:FindByName(nil, "npc_dire_titan"))
		if _G.RadiantDead >= (_G.radiant_players/2) then
		local units = FindUnitsInRadius(DOTA_TEAM_BADGUYS, thisEntity:GetAbsOrigin(), nil, 1000, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_FLAG_NONE, FIND_CLOSEST, false)
			for _, hero in ipairs(units) do
			if hero:IsRealHero() then
				thisEntity:SetAggroTarget(hero)
			else
				thisEntity:SetAggroTarget("npc_dire_titan")
			end
			break
			end
		end
		return 1
	end
	if _G.IsDual == true and thisEntity:GetTeamNumber() == 3 then
		thisEntity:MoveToTargetToAttack(Entities:FindByName(nil, "npc_radiant_titan"))
		thisEntity:SetAggroTarget(Entities:FindByName(nil, "npc_radiant_titan"))
		if _G.DireDead >= (_G.dire_players/2) then
		local units = FindUnitsInRadius(DOTA_TEAM_BADGUYS, thisEntity:GetAbsOrigin(), nil, 1000, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_FLAG_NONE, FIND_CLOSEST, false)
			for _, hero in ipairs(units) do
			if hero:IsRealHero() then
				thisEntity:SetAggroTarget(hero)
			else
				thisEntity:SetAggroTarget("npc_radiant_titan")
			end
			break
			end
		end
		return 1
	end
	if _G.IsDual == false and thisEntity:GetAggroTarget() ~= nil then
	local distance_from_target = (thisEntity:GetOrigin() - thisEntity:GetAggroTarget():GetOrigin()):Length2D()
		if distance_from_target >= 800 then
			thisEntity:SetAggroTarget(nil)
			
			return 1
		end
		return 1
	end
	if _G.IsDual == false and thisEntity:GetAggroTarget() == nil then
		if thisEntity:GetTeamNumber() == 2 then
			thisEntity:MoveToPosition(Entities:FindByName(nil, "rad_titan"):GetOrigin())
			
			return 1
		end
		
		if thisEntity:GetTeamNumber() == 3 then
			thisEntity:MoveToPosition(Entities:FindByName(nil, "dire_titan"):GetOrigin())
			
			return 1
		end
	end
	return 1
end

