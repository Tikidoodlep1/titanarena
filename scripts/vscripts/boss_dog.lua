require('gamemode')
function Spawn( entityKeyValues )
    ABILITY_leash = thisEntity:FindAbilityByName("boss_dog_leash")
    

    thisEntity:SetContextThink( "cast", cast , 2)
    print("Starting AI for "..thisEntity:GetUnitName().." "..thisEntity:GetEntityIndex())

end

function cast()

    if ABILITY_leash:IsFullyCastable() then
		thisEntity:CastAbilityImmediately(ABILITY_leash, -1)
		
		return 0.5
    end
	
    if thisEntity:GetAggroTarget() ~= nil then
		local distance_from_target = (thisEntity:GetOrigin() - thisEntity:GetAggroTarget():GetOrigin()):Length2D()
		local dist = (thisEntity:GetOrigin() - self.vInitialSpawnPos):Length2D()
		
		if distance_from_target >= 500 or dist > 500 then
			thisEntity:Stop()
			thisEntity:MoveToPositionAggressive(thisEntity.vInitialSpawnPos)
			
			return 1 
		end
		
		return .1
	end
	
	return .1
end