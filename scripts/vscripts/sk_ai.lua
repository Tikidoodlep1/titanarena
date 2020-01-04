require('gamemode')
function Spawn( entityKeyValues )
    ABILITY_epicenter = thisEntity:FindAbilityByName("sk_epicenter")
    

    thisEntity:SetContextThink( "cast", cast , 2)
    print("Starting AI for "..thisEntity:GetUnitName().." "..thisEntity:GetEntityIndex())

end

function cast()

    if (thisEntity:GetHealth() / thisEntity:GetMaxHealth()) <= .99 then
print("casting epicenter")
    thisEntity:Stop()
    thisEntity:CastAbilityOnTarget(thisEntity:GetAggroTarget(), ABILITY_epicenter , -1)

return 21 
    end
    if thisEntity:GetAggroTarget() ~= nil then
local distance_from_target = (thisEntity:GetOrigin() - thisEntity:GetAggroTarget():GetOrigin()):Length2D()
if distance_from_target >= 750 then
    thisEntity:SetAggoTarget(nil)
return .1 
end
return .1
end
return .1
end

