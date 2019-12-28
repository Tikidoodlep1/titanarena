require('gamemode')
function Spawn( entityKeyValues )
	ABILITY_blood_pact = thisEntity:FindAbilityByName("wanderer_blood_pact")

	thisEntity:SetContextThink( "roam", roam , 2)
	print("Starting AI for "..thisEntity:GetUnitName().." "..thisEntity:GetEntityIndex())

end

function roam()

if thisEntity:GetAggroTarget() == nil then
local low_x =  -13113.2
local high_x = 13227.8
local low_y = -4551.04
local high_y = 4272.83
print("wander has no target")
local go_to_x = RandomInt(low_x,high_x)
local go_to_y = RandomInt(low_y,high_y)
thisEntity:MoveToPositionAggressive(Vector(go_to_x,go_to_y,281))
return 2
	end 
if thisEntity:GetAggroTarget() ~= nil then
	if (thisEntity:GetHealth() / thisEntity:GetMaxHealth()) <= .99 then
print("casting ult")
	thisEntity:Stop()
	thisEntity:CastAbilityOnTarget(thisEntity:GetAggroTarget(), ABILITY_blood_pact , -1)



return 21
	end
local distance_from_target = (thisEntity:GetOrigin() - thisEntity:GetAggroTarget():GetOrigin()):Length2D()
if distance_from_target >= 750 then
	thisEntity:SetAggoTarget(nil)
return .1
end

end
end
