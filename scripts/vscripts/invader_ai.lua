require('gamemode')
require('events')
function Spawn( entityKeyValues )
	thisEntity:SetContextThink( "roam", roam , 1)
end

function roam()

if thisEntity:GetAggroTarget() == nil then
	if thisEntity:GetTeamNumber() == 2 then
		thisEntity:MoveToPosition(Entities:FindByName(nil, "dire_titan"):GetAbsOrigin())
		thisEntity:SetAggoTarget(Entities:FindByName(nil, "npc_dire_titan"))
		thisEntity:AddNewModifier(thisEntity, nil, "modifier_custom_invulnerable", {duration=10})
	else
		thisEntity:MoveToPosition(Entities:FindByName(nil, "rad_titan"):GetAbsOrigin())
		thisEntity:SetAggoTarget(Entities:FindByName(nil, "npc_radiant_titan"))
		thisEntity:AddNewModifier(thisEntity, nil, "modifier_custom_invulnerable", {duration=10})
	end
return 2
end 

local distance_from_target = (thisEntity:GetOrigin() - thisEntity:GetAggroTarget():GetOrigin()):Length2D()
if distance_from_target >= 500 then
	thisEntity:SetAggoTarget(nil)
return .1
end

end
