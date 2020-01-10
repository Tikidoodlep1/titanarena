require('gamemode')
function Spawn( entityKeyValues )
    ABILITY_epicenter = thisEntity:FindAbilityByName("sk_epicenter")
    

    thisEntity:SetContextThink( "cast", cast , 2)
    print("Starting AI for "..thisEntity:GetUnitName().." "..thisEntity:GetEntityIndex())

end

function cast()

    if (thisEntity:GetHealth() / thisEntity:GetMaxHealth()) <= .75 then
print("casting epicenter")
    thisEntity:Stop()
    thisEntity:CastAbilityOnTarget(thisEntity:GetAggroTarget(), ABILITY_epicenter , -1)

return 21
    end
    if thisEntity:GetAggroTarget() ~= nil then
local distance_from_target = (thisEntity:GetOrigin() - thisEntity:GetAggroTarget():GetOrigin()):Length2D()
if distance_from_target >= 750 then
    thisEntity:SetAggoTarget(nil)
	local radiant = GridNav:FindPathLength(thisEntity:GetAbsOrigin(), Entities:FindByName(nil, "rad_boss_sk"):GetAbsOrigin())
	local dire = GridNav:FindPathLength(thisEntity:GetAbsOrigin(), Entities:FindByName(nil, "dire_boss_sk"):GetAbsOrigin())
	if radiant < dire then
		local closest = Entities:FindByName(nil, "rad_boss_sk"):GetAbsOrigin()
	else
		local closest = Entities:FindByName(nil, "dire_boss_sk"):GetAbsOrigin()
	end
	thisEntity:MoveToPosition(closest)
return .1 
end
return .1
end
return .1
end