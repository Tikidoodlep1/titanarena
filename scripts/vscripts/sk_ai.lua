require('gamemode')
function Spawn( entityKeyValues )
	ABILITY_epicenter = thisEntity:FindAbilityByName("sk_epicenter")

	thisEntity:SetContextThink( "cast", cast , 1)
	local spawn = thisEntity:GetAbsOrigin()
Timers:CreateTimer(2, function()
	if (thisEntity:GetHealth() / thisEntity:GetMaxHealth()) <= .75 then
		thisEntity:Stop()
		thisEntity:CastAbilityNoTarget(ABILITY_epicenter , -1)
		print("attempting to cast epicenter")
	end
	return 2
end)
end

function cast()
if thisEntity:GetAggroTarget() == nil then
local ents = Entities:FindAllByClassname("npc_dota_creature")
for _,sk in ipairs(ents) do
if sk:GetUnitName() == "npc_boss_scarab" then
	thisEntity:MoveToPositionAggressive(sk:GetAbsOrigin())
end
end
return 5
end 

if thisEntity:GetAggroTarget() ~= nil then
local distance_from_target = (thisEntity:GetOrigin() - thisEntity:GetAggroTarget():GetOrigin()):Length2D()
if distance_from_target >= 750 then
	thisEntity:SetAggoTarget(nil)
	ThisEntity:MoveToPosition(spawn)
return 2
end

end
end
