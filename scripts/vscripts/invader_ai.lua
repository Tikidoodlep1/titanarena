require('gamemode')
require('events')
function Spawn( entityKeyValues )
	thisEntity:SetContextThink( "roam", roam , 1)
end

function roam()

if thisEntity:GetAggroTarget() == nil then
	if thisEntity:GetTeamNumber() == 2 then
		if	Entities:FindByName(nil, "npc_dire_titan") == nil then
			thisEntity:MoveToPositionAggressive(Entities:FindByName(nil, "dire_titan"):GetAbsOrigin())
			thisEntity:AddNewModifier(thisEntity, nil, "modifier_custom_invulnerable", {duration=6})
		else
			thisEntity:MoveToPosition(Entities:FindByName(nil, "dire_titan"):GetAbsOrigin())
			thisEntity:AddNewModifier(thisEntity, nil, "modifier_custom_invulnerable", {duration=6})
			Timers:CreateTimer(6, function()
				thisEntity:SetAggroTarget(Entities:FindByName(nil, "npc_radiant_titan"))
			end)
		end
	else
		if	Entities:FindByName(nil, "npc_radiant_titan") == nil then
			thisEntity:MoveToPositionAggressive(Entities:FindByName(nil, "rad_titan"):GetAbsOrigin())
			thisEntity:AddNewModifier(thisEntity, nil, "modifier_custom_invulnerable", {duration=6})
		else
			thisEntity:MoveToPosition(Entities:FindByName(nil, "rad_titan"):GetAbsOrigin())
			thisEntity:AddNewModifier(thisEntity, nil, "modifier_custom_invulnerable", {duration=6})
			Timers:CreateTimer(6, function()
				thisEntity:SetAggroTarget(Entities:FindByName(nil, "npc_radiant_titan"))
			end)
		end
	end
return 2
end 

local distance_from_target = (thisEntity:GetOrigin() - thisEntity:GetAggroTarget():GetOrigin()):Length2D()
if distance_from_target >= 500 then
	thisEntity:SetAggroTarget(nil)
return .1
end

end
