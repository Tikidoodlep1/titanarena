require('gamemode')
function Spawn( entityKeyValues )


	thisEntity:SetContextThink( "dual_actions", dual_actions , 2)
	print("Starting AI for "..thisEntity:GetUnitName().." "..thisEntity:GetEntityIndex())

end

function dual_actions()
	-- Sets up a simple boss roaming mechanic

	if _G.IsDual == true and thisEntity:GetTeamNumber() == 2 then
			thisEntity:MoveToTargetToAttack(Entities:FindByName(nil, "npc_dire_titan"))
			print("Radiant titan is targeting dire titan")
			return 2
		end
	if _G.IsDual == true and thisEntity:GetTeamNumber() == 3 then
			thisEntity:MoveToTargetToAttack(Entities:FindByName(nil, "npc_radiant_titan"))
			print("Dire titan is targeting radiant titan")
			return 2
	end

	if _G.IsDual == false and thisEntity:GetAggroTarget() == nil then
			if thisEntity:GetTeamNumber() == 2 then
					thisEntity:MoveToPosition(Entities:FindByName(nil, "rad_titan"):GetAbsOrigin())
					print("Radiant titan is returning to their spawn location")
			end

			if thisEntity:GetTeamNumber() == 3 then
				thisEntity:MoveToPosition(Entities:FindByName(nil, "dire_titan"):GetAbsOrigin())
				print("Dire titan is returning to their spawn location")
			end

	end
end