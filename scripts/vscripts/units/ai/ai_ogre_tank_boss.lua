LinkLuaModifier("ogre_tank_boss_jump_smash", "abilities/siltbreaker/npc_dota_creature_ogre_tank_boss/ogre_tank_boss_jump_smash.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("ogre_tank_boss_melee_smash", "abilities/siltbreaker/npc_dota_creature_ogre_tank_boss/ogre_tank_boss_melee_smash.lua", LUA_MODIFIER_MOTION_NONE)
function Spawn( entityKeyValues )
	if not IsServer() then
		return
	end

	if thisEntity == nil then
		return
	end

	SmashAbility = thisEntity:FindAbilityByName( "ogre_tank_boss_melee_smash" )
	JumpAbility = thisEntity:FindAbilityByName( "ogre_tank_boss_jump_smash" )

	thisEntity.hasteFactor = 1
	thisEntity.jumpChance = 80

	thisEntity:SetContextThink( "OgreTankBossThink", OgreTankBossThink, 1 )
end

function OgreTankBossThink()
	if ( not thisEntity:IsAlive() ) then
		return -1
	end
	
	if GameRules:IsGamePaused() == true then
		return 1
	end

		if not thisEntity.bInitialized then
		thisEntity.vInitialSpawnPos = thisEntity:GetOrigin()
		thisEntity.bInitialized = true
	end

		-- Are we too far from our initial spawn position?
	local fDist = ( thisEntity:GetOrigin() - thisEntity.vInitialSpawnPos ):Length2D()
	if fDist > 1500 then
		RetreatHome()
		return 2.0
	end

	local closeEnemy = false
	local enemies = FindUnitsInRadius(thisEntity:GetTeamNumber(),
									  thisEntity:GetOrigin(),
									   nil,
									   1000,
									   DOTA_UNIT_TARGET_TEAM_ENEMY,
									   DOTA_UNIT_TARGET_HERO,
									   DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
									   FIND_CLOSEST,
									   false)
	for i = 1, #enemies do
		local enemy = enemies[i]
		if enemy ~= nil then
			local flDist = ( enemy:GetOrigin() - thisEntity:GetOrigin() ):Length2D()
			if flDist < 300 then
				closeEnemy = true
			end
		end
	end

	if JumpAbility ~= nil and JumpAbility:IsFullyCastable() and closeEnemy then
		if thisEntity.jumpChance > RandomInt(1,100) then
			return Jump()
		end
	end

	if #enemies == 0 then
		if fDist >= 400 then
			thisEntity:SetAggroTarget(nil)
			
		print("No nearby enemies")
	end
		return 1
	end

	if SmashAbility ~= nil and SmashAbility:IsFullyCastable() then
		return Smash( enemies[ 1 ] )
	end

	print("Nothing")
	
	return 0.5
end


function Jump()
	ExecuteOrderFromTable({
		UnitIndex = thisEntity:entindex(),
		OrderType = DOTA_UNIT_ORDER_CAST_NO_TARGET,
		AbilityIndex = JumpAbility:entindex(),
		Queue = false,
	})
	
	return 3.0
end


function Smash( enemy )
	if enemy == nil then
		return
	end

	if ( not thisEntity:HasModifier( "modifier_provide_vision" ) ) then
		--print( "If player can't see me, provide brief vision to his team as I start my Smash" )
		thisEntity:AddNewModifier( thisEntity, nil, "modifier_provide_vision", { duration = 1.5 } )
	end

	-- local direction = enemy:GetForwardVector():Normalized()
 --    local smashPrediction = enemy:GetAbsOrigin() + direction * RandomInt(0,300)

	ExecuteOrderFromTable({
		UnitIndex = thisEntity:entindex(),
		OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
		AbilityIndex = SmashAbility:entindex(),
		Position = enemy:GetAbsOrigin(),
		Queue = false,
	})

	return 3.0 / thisEntity.hasteFactor
end

function RetreatHome()
	--print( "OgreTankBoss - RetreatHome()" )

	ExecuteOrderFromTable({
		UnitIndex = thisEntity:entindex(),
		OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
		Position = thisEntity.vInitialSpawnPos
	})
end