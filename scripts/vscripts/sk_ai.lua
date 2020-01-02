require('gamemode')
function Spawn( entityKeyValues )
	ABILITY_eipcenter = thisEntity:FindAbilityByName("sk_epicenter")

	thisEntity:SetContextThink( "cast", cast , 1)
	print("Starting AI for "..thisEntity:GetUnitName().." "..thisEntity:GetEntityIndex())
	local spawn = thisEntity:GetAbsOrigin()
end

function cast()
if thisEntity:GetAggroTarget() == nil then
local ents = Entities:FindAllByClassname("npc_dota_creature")
for _,sk in ipairs(ents) do
if sk:GetUnitName() == "npc_boss_scarab" then
	thisEntity:MoveToPositionAggressive(sk:GetAbsOrigin())
end
end
return 1
end 
if thisEntity:GetAggroTarget() ~= nil then
	if (thisEntity:GetHealth() / thisEntity:GetMaxHealth()) <= .99 then
print("casting epicenter")
	thisEntity:Stop()
	thisEntity:CastAbilityOnTarget(thisEntity:GetAggroTarget(), ABILITY_epicenter , -1)

return 2
	end
local distance_from_target = (thisEntity:GetOrigin() - thisEntity:GetAggroTarget():GetOrigin()):Length2D()
if distance_from_target >= 750 then
	thisEntity:SetAggoTarget(nil)
	ThisEntity:MoveToPosition(spawn)
return .1
end

end
end
