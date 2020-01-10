-- This file contains all barebones-registered events and has already set up the passed-in parameters for you to use.
-- You should comment the stuff you don't need

-- Handle stuff when a player disconnects
function barebones:OnDisconnect(keys)
	DebugPrint("[BAREBONES] A Player has disconnected ".. tostring(keys.userid))
	--PrintTable(keys)

	local name = keys.name
	local networkID = keys.networkid
	local reason = keys.reason
	local userID = keys.userid
end

-- The overall game state has changed
function barebones:OnGameRulesStateChange(keys)
	--PrintTable(keys)

	local new_state = GameRules:State_Get()

	if new_state == DOTA_GAMERULES_STATE_INIT then
		DebugPrint("[BAREBONES] Game State changed to: DOTA_GAMERULES_STATE_INIT")

	elseif new_state == DOTA_GAMERULES_STATE_WAIT_FOR_PLAYERS_TO_LOAD then
		DebugPrint("[BAREBONES] Game State changed to: DOTA_GAMERULES_STATE_WAIT_FOR_PLAYERS_TO_LOAD")

	elseif new_state == DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP then
		DebugPrint("[BAREBONES] Game State changed to: DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP")
		GameRules:SetCustomGameSetupAutoLaunchDelay(CUSTOM_GAME_SETUP_TIME)

	elseif new_state == DOTA_GAMERULES_STATE_HERO_SELECTION then
		DebugPrint("[BAREBONES] Game State changed to: DOTA_GAMERULES_STATE_HERO_SELECTION")
		self:PostLoadPrecache()
		self:OnAllPlayersLoaded()
		_G.radiant_kills = 0
		_G.dire_kills = 0
		_G.vote_to_concede_dire = false
		_G.vote_to_concede_radiant = false
		_G.radiant_can_concede = true
		_G.dire_can_concede = true

		Timers:CreateTimer(HERO_SELECTION_TIME+STRATEGY_TIME-1, function()
			for playerID = 0, DOTA_MAX_TEAM_PLAYERS-1 do
				if PlayerResource:IsValidPlayerID(playerID) then
					-- If this player still hasn't picked a hero, random one
					-- PlayerResource:IsConnected(index) is custom-made; can be found in 'player_resource.lua' library
					if not PlayerResource:HasSelectedHero(playerID) and PlayerResource:IsConnected(playerID) and (not PlayerResource:IsBroadcaster(playerID)) then
						PlayerResource:GetPlayer(playerID):MakeRandomHeroSelection() -- this will cause an error if player is disconnected
						PlayerResource:SetHasRandomed(playerID)
						PlayerResource:SetCanRepick(playerID, false)
						DebugPrint("[BAREBONES] Randomed a hero for a player number "..playerID)
					end
				end
			end
		end)

	elseif new_state == DOTA_GAMERULES_STATE_STRATEGY_TIME then
		DebugPrint("[BAREBONES] Game State changed to: DOTA_GAMERULES_STATE_STRATEGY_TIME")

	elseif new_state == DOTA_GAMERULES_STATE_TEAM_SHOWCASE then
		DebugPrint("[BAREBONES] Game State changed to: DOTA_GAMERULES_STATE_TEAM_SHOWCASE")

	elseif new_state == DOTA_GAMERULES_STATE_WAIT_FOR_MAP_TO_LOAD then
		DebugPrint("[BAREBONES] Game State changed to: DOTA_GAMERULES_STATE_WAIT_FOR_MAP_TO_LOAD")

	elseif new_state == DOTA_GAMERULES_STATE_PRE_GAME then
		DebugPrint("[BAREBONES] Game State changed to: DOTA_GAMERULES_STATE_PRE_GAME")
			
	elseif new_state == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		DebugPrint("[BAREBONES] Game State changed to: DOTA_GAMERULES_STATE_GAME_IN_PROGRESS")
		self:OnGameInProgress()

	elseif new_state == DOTA_GAMERULES_STATE_POST_GAME then
		DebugPrint("[BAREBONES] Game State changed to: DOTA_GAMERULES_STATE_POST_GAME")

	elseif new_state == DOTA_GAMERULES_STATE_DISCONNECT then
		DebugPrint("[BAREBONES] Game State changed to: DOTA_GAMERULES_STATE_DISCONNECT")

	end
end

-- An NPC has spawned somewhere in game.  This includes heroes
function barebones:OnNPCSpawned(keys)
	DebugPrint("[BAREBONES] A unit Spawned")
	--PrintTable(keys)

	local npc = EntIndexToHScript(keys.entindex)
	local unit_owner = npc:GetOwner()

	-- Put things here that will happen for every unit or hero when they spawn

	-- OnHeroInGame (can be found in 'gamemode.lua')
	if npc:IsRealHero() and npc.bFirstSpawned == nil then
		npc.bFirstSpawned = true
		self:OnHeroInGame(npc)
	end
end

-- An item was picked up off the ground
function barebones:OnItemPickedUp(keys)
	DebugPrint("[BAREBONES] OnItemPickedUp")
	--PrintTable(keys)

	local unit_entity
	if keys.UnitEntitIndex then
		unit_entity = EntIndexToHScript(keys.UnitEntitIndex)
	elseif keys.HeroEntityIndex then
		unit_entity = EntIndexToHScript(keys.HeroEntityIndex)
	end

	local item_entity = EntIndexToHScript(keys.ItemEntityIndex)
	local playerID = keys.PlayerID
	local item_name = keys.itemname
end

-- A player has reconnected to the game. This function can be used to repaint Player-based particles or change state as necessary
function barebones:OnPlayerReconnect(keys)
	DebugPrint("[BAREBONES] A Player has reconnected.")
	--PrintTable(keys)

	--local name = keys.name
	--local network_id = keys.networkid
	--local user_id = keys.userid
	--local xu_id = keys.xuid
	--local reason = keys.reason

	local new_state = GameRules:State_Get()
	if new_state > DOTA_GAMERULES_STATE_HERO_SELECTION then
		local playerID = keys.PlayerID

		if PlayerResource:HasSelectedHero(playerID) or PlayerResource:HasRandomed(playerID) then
			-- This playerID already had a hero before disconnect
		else
			-- PlayerResource:IsConnected(index) is custom-made; can be found in 'player_resource.lua' library
			if PlayerResource:IsConnected(playerID) and (not PlayerResource:IsBroadcaster(playerID)) then
				PlayerResource:GetPlayer(playerID):MakeRandomHeroSelection()
				PlayerResource:SetHasRandomed(playerID)
				PlayerResource:SetCanRepick(playerID, false)
				DebugPrint("[BAREBONES] Randomed a hero for a player number "..playerID.." that reconnected.")
			end
		end
	end
end

-- An item was purchased by a player
function barebones:OnItemPurchased(keys)
	DebugPrint("[BAREBONES] OnItemPurchased")
	--PrintTable(keys)

	-- The playerID of the hero who is buying something
	local playerID = keys.PlayerID
	if not playerID then
		return
	end

	-- The name of the item purchased
	local item_name = keys.itemname

	-- The cost of the item purchased
	local item_cost = keys.itemcost
end

-- An ability was used by a player
function barebones:OnAbilityUsed(keys)
	--PrintTable(keys)

	local playerID = keys.PlayerID
	local ability_name = keys.abilityname

	-- If you need to adjust abilities on their cast, use Order Filter, not this
end

-- A non-player entity (necronomicon unit, chen creep, etc) used an ability
function barebones:OnNonPlayerUsedAbility(keys)
	--PrintTable(keys)

	local ability_name = keys.abilityname

	-- If you need to adjust abilities on their cast, use Order Filter, not this
end

-- A player changed their name, useless in most cases
function barebones:OnPlayerChangedName(keys)
	--PrintTable(keys)

	local new_name = keys.newname
	local old_name = keys.oldName
end

-- A player leveled up an ability; Note: IT DOESN'T TRIGGER WHEN YOU USE SetLevel() ON THE ABILITY!
function barebones:OnPlayerLearnedAbility(keys)
	DebugPrint("[BAREBONES] OnPlayerLearnedAbility")
	--PrintTable(keys)

	local player = EntIndexToHScript(keys.player)
	local ability_name = keys.abilityname

	local playerID
	if player then
		playerID = player:GetPlayerID()
	else
		playerID = keys.PlayerID
	end

    -- PlayerResource:GetAssignedHero(index) is custom-made;can be found in 'player_resource.lua' library
	local hero = PlayerResource:GetAssignedHero(playerID)

	-- Handling talents without custom net tables, this is just an example
	local talents = {
		{"special_bonus_unique_chaos_knight", "modifier_reality_rift_talent_1"},
		{"special_bonus_unique_chaos_knight_2", "modifier_reality_rift_talent_2"}
	}

	for i = 1, #talents do
		local talent = talents[i]
		if ability_name == talent[1] then
			local talent_ability = hero:FindAbilityByName(ability_name)
			if talent_ability then
				local talent_modifier = talent[2]
				hero:AddNewModifier(hero, talent_ability, talent_modifier, {})
			end
		end
	end
end

-- A channelled ability finished by either completing or being interrupted
function barebones:OnAbilityChannelFinished(keys)
	DebugPrint("[BAREBONES] OnAbilityChannelFinished")
	--PrintTable(keys)

	local ability_name = keys.abilityname
	local interrupted = keys.interrupted == 1
end

-- A player leveled up
function barebones:OnPlayerLevelUp(keys)
	DebugPrint("[BAREBONES] OnPlayerLevelUp")
	--PrintTable(keys)

	local player = EntIndexToHScript(keys.player)
	local level = keys.level

	local playerID
	local hero
	if player then
		playerID = player:GetPlayerID()
		hero = PlayerResource:GetAssignedHero(playerID)
	end

	if hero then
		-- Update hero gold bounty when a hero gains a level
		if USE_CUSTOM_HERO_GOLD_BOUNTY then
			local hero_level = hero:GetLevel() or level
			local hero_streak = hero:GetStreak()

			local gold_bounty
			if hero_streak > 2 then
				gold_bounty = HERO_KILL_GOLD_BASE + hero_level*HERO_KILL_GOLD_PER_LEVEL + (hero_streak-2)*HERO_KILL_GOLD_PER_STREAK
			else
				gold_bounty = HERO_KILL_GOLD_BASE + hero_level*HERO_KILL_GOLD_PER_LEVEL
			end

			hero:SetMinimumGoldBounty(gold_bounty)
			hero:SetMaximumGoldBounty(gold_bounty)
		end
		
		if hero:GetLevel() == 35 or hero:GetLevel() == 45  or hero:GetLevel() == 50 then
			hero:SetAbilityPoints(hero:GetAbilityPoints() + 1)
		end

		-- Add a skill point when a hero levels
		if SKILL_POINTS_AT_EVERY_LEVEL then
			local levels_without_ability_point = {17, 19, 21, 22, 23, 24}	-- on this levels you should get a skill point
			for i = 1, #levels_without_ability_point do
				if level == levels_without_ability_point[i] then
					local unspent_ability_points = hero:GetAbilityPoints()
					hero:SetAbilityPoints(unspent_ability_points+1)
				end
			end
		end

		-- If you want to remove skill points when a hero levels up then uncomment the following line:
		--hero:SetAbilityPoints(0)
	end
end

-- A player last hit a creep, a tower, or a hero
function barebones:OnLastHit(keys)
	DebugPrint("[BAREBONES] OnLastHit")
	--PrintTable(keys)

	local IsFirstBlood = keys.FirstBlood == 1
	local IsHeroKill = keys.HeroKill == 1
	local IsTowerKill = keys.TowerKill == 1

	-- Player ID that got a last hit
	local playerID = keys.PlayerID

	-- Killed unit (creep, hero, tower etc.)
	local killed_entity = EntIndexToHScript(keys.EntKilled)
end

-- A tree was cut down by tango, quelling blade, etc
function barebones:OnTreeCut(keys)
	DebugPrint("[BAREBONES] OnTreeCut")
	--PrintTable(keys)

	-- Tree coordinates on the map
	local treeX = keys.tree_x
	local treeY = keys.tree_y
end

-- A rune was activated by a player
function barebones:OnRuneActivated(keys)
	DebugPrint("[BAREBONES] OnRuneActivated")
	--PrintTable(keys)

  local playerID = keys.PlayerID
  local rune = keys.rune

  -- For Bounty Runes use BountyRuneFilter
  -- For modifying which runes spawn use RuneSpawnFilter
  -- This event can be used for adding more effects to existing runes.
end

-- A player took damage from a tower
function barebones:OnPlayerTakeTowerDamage(keys)
	DebugPrint("[BAREBONES] OnPlayerTakeTowerDamage")
	--PrintTable(keys)

	local playerID = keys.PlayerID
	local damage = keys.damage
end

-- A player picked or randomed a hero (this is happening before OnHeroInGame because OnHeroInGame has a timers delay).
function barebones:OnPlayerPickHero(keys)
	DebugPrint("[BAREBONES] OnPlayerPickHero")
	--PrintTable(keys)

	local hero_name = keys.hero
	local hero_entity = EntIndexToHScript(keys.heroindex)
	local player = EntIndexToHScript(keys.player)

	Timers:CreateTimer(0.5, function()
		local playerID = hero_entity:GetPlayerID() -- or player:GetPlayerID() if player is not disconnected
		if PlayerResource:IsFakeClient(playerID) then
			-- This is happening only for bots when they spawn for the first time or if they use custom hero-create spells (Custom Illusion spells)
		else
			if not PlayerResource.PlayerData[playerID] then
				PlayerResource.PlayerData[playerID] = {}
				DebugPrint("[BAREBONES] PlayerResource's PlayerData for playerID "..playerID.." was not properly initialized.")
			end
			if PlayerResource.PlayerData[playerID].already_assigned_hero == true then
				-- This is happening only when players create new heroes with spells (Custom Illusion spells)
			else
				PlayerResource:AssignHero(playerID, hero_entity)
				PlayerResource.PlayerData[playerID].already_assigned_hero = true
			end
		end
	end)
end

-- A player killed another player in a multi-team context
function barebones:OnTeamKillCredit(keys)
	DebugPrint("[BAREBONES] OnTeamKillCredit")
	--PrintTable(keys)

	local killer_userID = keys.killer_userid
	local victim_userID = keys.victim_userid
	local streak = keys.herokills
	local killer_team = keys.teamnumber
	-- If you want to change assist gold or assist experience on hero death use OnEntityKilled or Damage Filter, not this
end

-- An entity died (an entity killed an entity)
function barebones:OnEntityKilled(keys)

	DebugPrint("[BAREBONES] An entity was killed.")
	--PrintTable(keys)

	-- The Unit that was Killed
	local killed_unit = EntIndexToHScript(keys.entindex_killed)

	-- The Killing entity
	local killer_unit = nil

	local team = killed_unit:GetTeamNumber()

if team == 2 then
_G.dire_kills = (_G.dire_kills + 1)
--checks to see if a team has hit the minimum number of kills to win
if _G.dire_kills == 50 then
	GameRules:SetGameWinner(3)
	end
end
if team == 3 then
_G.radiant_kills = (_G.radiant_kills + 1)
--checks to see if a team has hit the minimum number of kills to win
if _G.radiant_kills == 50 then
	GameRules:SetGameWinner(2)
	end
end
	
	if killed_unit:IsCreature() then
		RollDrops(killed_unit)
	end
	
	if keys.entindex_attacker ~= nil then
		killer_unit = EntIndexToHScript(keys.entindex_attacker)
	end
	local players = HeroList:GetAllHeroes()
	if killed_unit:GetUnitName() == "npc_boss_et_phys" or killed_unit:GetUnitName() == "npc_boss_et_mag" then
		for _, hero in ipairs(players) do
			if hero:GetTeamNumber() == killer_unit:GetTeamNumber() then
				PlayerResource:ModifyGold(hero:GetPlayerID(), 500, true, 14)
				hero:AddExperience(5000, 3, false, true)
			end
		end			
	end
	if killed_unit:GetUnitName() == "npc_boss_dragon_knight_2" or killed_unit:GetUnitName() == "npc_boss_dragon_knight_1" then
		for _, hero in ipairs(players) do
			if hero:GetTeamNumber() == killer_unit:GetTeamNumber() then
				PlayerResource:ModifyGold(hero:GetPlayerID(), 700, true, 14)
				hero:AddExperience(1500, 3, false, true)
			end
		end			
	end
	if killed_unit:GetUnitName() == "npc_boss_scarab" then
		for _, hero in ipairs(players) do
			if hero:GetTeamNumber() == killer_unit:GetTeamNumber() then
				PlayerResource:ModifyGold(hero:GetPlayerID(), 700, true, 14)
				hero:AddExperience(3000, 3, false, true)
			end
		end			
	end
	if killed_unit:GetUnitName() == "npc_boss_wanderer" then
		for _, hero in ipairs(players) do
			if hero:GetTeamNumber() == killer_unit:GetTeamNumber() then
				PlayerResource:ModifyGold(hero:GetPlayerID(), 1500, true, 14)
				hero:AddExperience(7000, 3, false, true)
			end
		end			
	end
	
	if killed_unit:GetUnitName() == "npc_dire_titan" then
		Notifications:TopToAll({text = "The Dire Titan Has Been Slain!", duration=5.0})
		for _, hero in ipairs(players) do
			if hero:GetTeamNumber() == 2 then
				hero:AddNewModifier(hero, nil, "modifier_titan_slain", {duration=600})
			end
		end
	elseif killed_unit:GetUnitName() == "npc_radiant_titan" then
		Notifications:TopToAll({text = "The Radiant Titan Has Been Slain!", duration=5.0})
		for _, hero in ipairs(players) do
			if hero:GetTeamNumber() == 3 then
				hero:AddNewModifier(hero, nil, "modifier_titan_slain", {duration=600})
			end
		end
	end
	
	if killed_unit:IsRealHero() == true and killer_unit:GetClassname() == "npc_dota_creature" then
		killed_unit:SetTimeUntilRespawn(killed_unit:GetTimeUntilRespawn() / 4)
	end
	
	--[[require('gamemode')
	local checkFunction = gamemode.CheckDualStatus()
	checkFunction()
	--]]
	
	-- The ability/item used to kill, or nil if not killed by an item/ability
	local killing_ability = nil

	if keys.entindex_inflictor ~= nil then
		killing_ability = EntIndexToHScript(keys.entindex_inflictor)
	end

	-- For Meepo clones, find the original
	if killed_unit:IsClone() then
		if killed_unit:GetCloneSource() then
			killed_unit = killed_unit:GetCloneSource()
		end
	end

	-- Killed Unit is a hero (not an illusion) and he is not reincarnating
	if killed_unit:IsRealHero() and (not killed_unit:IsReincarnating()) then

		--Handles scripts for end game and setting and checking current team kills
	if killer_unit:IsRealHero() then
		print("awarded a team a kill!")

	end

	local players = HeroList:GetAllHeroes()
	if  _G.IsDual == true then
	if killed_unit:IsRealHero() and not killed_unit:IsIllusion() and killed_unit:GetTeamNumber() == 2 then
			_G.RadiantDead = _G.RadiantDead + 1
			print(_G.RadiantDead .. " radiant dead" .. " out of" .. _G.radiant_players)

	end
	if killed_unit:IsRealHero() and not killed_unit:IsIllusion() and killed_unit:GetTeamNumber() == 3 then
		_G.DireDead = _G.DireDead + 1
		print(_G.DireDead .. " dire dead" .. " out of" .. _G.dire_players)
				

		end
		if _G.DireDead == _G.dire_players then
			ExitDualWinner(2)
		end
		if _G.RadiantDead == _G.radiant_players then
			ExitDualWinner(3)
		end
	end

		-- Hero gold bounty update for the killer
		if USE_CUSTOM_HERO_GOLD_BOUNTY then
			if killer_unit:IsRealHero() then
				-- Get his killing streak
				local hero_streak = killer_unit:GetStreak()
				-- Get his level
				local hero_level = killer_unit:GetLevel()
				-- Adjust Gold bounty
				local gold_bounty
				if hero_streak > 2 then
					gold_bounty = HERO_KILL_GOLD_BASE + hero_level*HERO_KILL_GOLD_PER_LEVEL + (hero_streak-2)*HERO_KILL_GOLD_PER_STREAK
				else
					gold_bounty = HERO_KILL_GOLD_BASE + hero_level*HERO_KILL_GOLD_PER_LEVEL
				end

				killer_unit:SetMinimumGoldBounty(gold_bounty)
				killer_unit:SetMaximumGoldBounty(gold_bounty)
			end
		end


		-- Hero Respawn time configuration
		if ENABLE_HERO_RESPAWN then
			local killed_unit_level = killed_unit:GetLevel()

			-- Respawn time without buyback penalty (+25 sec)
			local respawn_time = 1
			if USE_CUSTOM_RESPAWN_TIMES then
				-- Get respawn time from the table that we defined
				respawn_time = CUSTOM_RESPAWN_TIME[killed_unit_level]
			else
				-- Get dota default respawn time
				respawn_time = killed_unit:GetRespawnTime()
			end

			-- Fixing respawn time after level 25, this is usually bugged in custom games
			local respawn_time_after_25 = 100 + (killed_unit_level-25)*5
			if killed_unit_level > 25 and respawn_time < respawn_time_after_25	then
				respawn_time = respawn_time_after_25
			end

			-- Bloodstone reduction (bloodstone can't be in backpack)
			-- for i=DOTA_ITEM_SLOT_1, DOTA_ITEM_SLOT_6 do
				-- local item = killed_unit:GetItemInSlot(i)
				-- if item then
					-- if item:GetName() == "item_bloodstone" then
						-- local current_charges = item:GetCurrentCharges()
						-- local charges_before_death = math.ceil(current_charges*1.5)
						-- local reduction_per_charge = item:GetLevelSpecialValueFor("respawn_time_reduction", item:GetLevel() - 1)
						-- local respawn_reduction = charges_before_death*reduction_per_charge
						-- respawn_time = math.max(1, respawn_time-respawn_reduction)
						-- break -- break the for loop, to prevent multiple bloodstones granting respawn reduction
					-- end
				-- end
			-- end

			-- Reaper's Scythe respawn time increase
			if killing_ability then
				if killing_ability:GetAbilityName() == "necrolyte_reapers_scythe" then
					DebugPrint("[BAREBONES] A hero was killed by a Necro Reaper's Scythe. Increasing respawn time!")
					local respawn_extra_time = killing_ability:GetLevelSpecialValueFor("respawn_constant", killing_ability:GetLevel() - 1)
					respawn_time = respawn_time + respawn_extra_time
				end
			end

			-- Killer is a neutral creep
			if killer_unit:IsNeutralUnitType() then
				-- If a hero is killed by a neutral creep, respawn time can be modified here
			end

			-- Maximum Respawn Time
			if respawn_time > MAX_RESPAWN_TIME then
				DebugPrint("Reducing respawn time of "..killed_unit:GetUnitName().." because it was too long.")
				respawn_time = MAX_RESPAWN_TIME
			end

			if not killed_unit:IsReincarnating() then
				killed_unit:SetTimeUntilRespawn(respawn_time)
			end
		end

		-- Buyback Cooldown
		if CUSTOM_BUYBACK_COOLDOWN_ENABLED then
			PlayerResource:SetCustomBuybackCooldown(killed_unit:GetPlayerID(), CUSTOM_BUYBACK_COOLDOWN_TIME)
		end

		-- Buyback Fixed Gold Cost
		if CUSTOM_BUYBACK_COST_ENABLED then
			PlayerResource:SetCustomBuybackCost(killed_unit:GetPlayerID(), BUYBACK_FIXED_GOLD_COST)
		end

		-- Killer is not a real hero but it killed a hero
		if killer_unit:IsTower() or killer_unit:IsCreep() or killer_unit:IsFountain() then
			-- Put stuff here that you want to happen if a hero is killed by a creep, tower or fountain.
		end

		-- When team hero kill limit is reached declare the winner
		if END_GAME_ON_KILLS and GetTeamHeroKills(killer_unit:GetTeam()) >= KILLS_TO_END_GAME_FOR_TEAM then
			GameRules:SetGameWinner(killer_unit:GetTeam())
		end

		-- Setting top bar values
		if SHOW_KILLS_ON_TOPBAR then
			GameRules:GetGameModeEntity():SetTopBarTeamValue(DOTA_TEAM_BADGUYS, GetTeamHeroKills(DOTA_TEAM_BADGUYS))
			GameRules:GetGameModeEntity():SetTopBarTeamValue(DOTA_TEAM_GOODGUYS, GetTeamHeroKills(DOTA_TEAM_GOODGUYS))
		end
	end

	-- Ancient destruction detection (if the map doesn't have ancients with these names, this will never happen)
	if killed_unit:GetUnitName() == "npc_dota_badguys_fort" then
		GameRules:SetGameWinner(DOTA_TEAM_GOODGUYS)
		GameRules:SetCustomVictoryMessage("#dota_post_game_radiant_victory")
		GameRules:SetCustomVictoryMessageDuration(POST_GAME_TIME)
	elseif killed_unit:GetUnitName() == "npc_dota_goodguys_fort" then
		GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
		GameRules:SetCustomVictoryMessage("#dota_post_game_dire_victory")
		GameRules:SetCustomVictoryMessageDuration(POST_GAME_TIME)
	end

	-- Remove dead non-hero units from selection -> bugged ability/cast bar
	if killed_unit:IsIllusion() or (killed_unit:IsControllableByAnyPlayer() and (not killed_unit:IsRealHero()) and (not killed_unit:IsCourier()) and (not killed_unit:IsClone())) and (not killed_unit:IsTempestDouble()) then
		local player = killed_unit:GetPlayerOwner()
		local playerID
		if player == nil then
			playerID = killed_unit:GetPlayerOwnerID()
		else
			playerID = player:GetPlayerID()
		end
		
		if Selection then
			-- Without Selection library this will return an error
			PlayerResource:RemoveFromSelection(playerID, killed_unit)
		end
	end
end



function ExitDualWinner(WinningTeam)
print("Called ExitDualWinner with winning team as "..WinningTeam)
	_G.IsDual = false
	_G.DireDead = 0
	_G.RadiantDead = 0
	GameRules:SetHeroRespawnEnabled(true)
	local players = HeroList:GetAllHeroes()
		for _, hero in pairs(players) do
			hero:SetBuyBackDisabledByReapersScythe(false)
			if hero:IsAlive() == false then
                hero:RespawnUnit()
            end
			if hero:GetTeamNumber() == 2 then
                FindClearSpaceForUnit(hero, Entities:FindByName(nil, "radiant_spawn"):GetAbsOrigin(), true)
                hero:RemoveModifierByName("modifier_battle_cup_effigy")
                hero:RemoveModifierByName("modifier_truesight")
                SendToConsole("dota_camera_center")
            elseif hero:GetTeamNumber() == 3 then
                FindClearSpaceForUnit(hero, Entities:FindByName(nil, "dire_spawn"):GetAbsOrigin(), true)
                hero:RemoveModifierByName("modifier_battle_cup_effigy")
                hero:RemoveModifierByName("modifier_truesight")
                SendToConsole("dota_camera_center")
            end
			print("respawned units and removed modifiers")
		end
		local Creatures = Entities:FindAllByClassname("npc_dota_creature")
		local radiant_titan_return = Entities:FindByName(nil, "rad_titan"):GetAbsOrigin()
		local dire_titan_return = Entities:FindByName(nil, "dire_titan"):GetAbsOrigin()
		for _, unit in ipairs(Creatures) do
			if unit:GetUnitName() == "npc_radiant_titan" then
				FindClearSpaceForUnit(unit, radiant_titan_return, false)
				unit:RemoveModifierByName("modifier_titan_in_dual")
				unit:Stop()
				break
			end
		end
		for _, unit in ipairs(Creatures) do
			if unit:GetUnitName() == "npc_dire_titan" then
				FindClearSpaceForUnit(unit, dire_titan_return, false)
				unit:RemoveModifierByName("modifier_titan_in_dual")
				unit:Stop()
				break
			end
		end
		print("teleported titans")
		local Heroes = HeroList:GetAllHeroes()
		local team_networth = 0
		local player_networth = 0
		local amount = 0
		local ID
		local game_time = GameRules:GetGameTime()
		local current_gold
		for _, players in ipairs(Heroes) do
			if players:GetTeamNumber() == WinningTeam and players:IsClone() == false then
			ID = players:GetPlayerID()
				amount = 750 * 1.85^(game_time/600)
				current_gold = PlayerResource:GetGold(ID)
				players:SetGold(current_gold + amount + 1, false)
			end

		end
		if WinningTeam == 2 then
		Notifications:TopToAll({text = "The Radiant Won And Recieved "..amount.." Gold!", duration=5.0})
		EmitGlobalSound("ui.contract_complete")
		end
		if WinningTeam == 3 then
		Notifications:TopToAll({text = "The Dire Won And Recieved "..amount.." Gold!", duration=5.0})
		EmitGlobalSound("ui.contract_complete")
		end
		local trigger_out = Entities:FindByName(nil, "dual_keepout_trigger")
		local trigger_out1 = Entities:FindByName(nil, "dual_keepout1_trigger")
			trigger_out:Disable()
			trigger_out1:Disable()
		local trigger_in = {}
		trigger_in[1] = Entities:FindByName(nil, "dual_keepin_trigger")
		trigger_in[2] = Entities:FindByName(nil, "dual_keepin1_trigger")
		trigger_in[3] = Entities:FindByName(nil, "dual_keepin2_trigger")
		trigger_in[4] = Entities:FindByName(nil, "dual_keepin3_trigger")
		trigger_in[5] = Entities:FindByName(nil, "dual_keepin4_trigger")
		for _, trigger in pairs(trigger_in) do
			trigger:Disable()
		end
		--[[for r=1,5 do
		CreateUnitByName("npc_invader", Entities:FindByName(nil, "invaders_rad_spawn"):GetAbsOrigin(), true, nil, nil, 2):CreatureLevelUp(_G.invaderlevel)
		r = r + 1
		end
		for d=1,5 do
		CreateUnitByName("npc_invader", Entities:FindByName(nil, "invaders_dire_spawn"):GetAbsOrigin(), true, nil, nil, 3):CreatureLevelUp(_G.invaderlevel)
		d = d + 1
		end
		_G.invaderlevel = _G.invaderlevel + 1
		print("spawned invaders")
		--]]
	end

if team == 3 then
_G.radiant_kills = (_G.radiant_kills + 1)

--checks to see if a team has hit the minimum number of kills to win
if _G.radiant_kills == 50 then
	GameRules:SetGameWinner(2)
end
end


function RollDrops(unit)
		local dropinfo = GameRules.DropTable[unit:GetUnitName()]
		if dropinfo then
			for k,ItemTable in pairs(dropinfo) do
				local item_name
				if ItemTable.ItemSets then
					local count = 0
					for i, v in pairs(ItemTable.ItemSets) do
						count = count + 1
					end
					local rand = RandomInt(1, count)
					item_name = ItemTable.ItemSets[tostring(rand)]
				else
					item_name = ItemTable.Item
				end
				local chance = ItemTable.Chance or 100
				local max_drops = ItemTable.Multiple or 1
				for i=1, max_drops do
					if RollPercentage(chance) == true then
					print("percent <= chance!")
						local item = CreateItem(item_name, nil, nil)
						local pos = unit:GetAbsOrigin()
						local drop = CreateItemOnPositionSync(pos, item)
						local pos_launch = pos+RandomVector(RandomFloat(150,200))
						item:LaunchLoot(false, 200, 0.75, pos_launch)
					end
				end
			end
		end
	end
	
-- This function is called once when the player fully connects and becomes "Ready" during Loading
function barebones:OnConnectFull(keys)
	DebugPrint("[BAREBONES] A Player fully connected.")
	--PrintTable(keys)

	self:CaptureGameMode()

	local index = keys.index
	local playerID = keys.PlayerID
	local userID = keys.userid

	-- PlayerResource:OnPlayerConnect(event) is custom-made; can be found in 'player_resource.lua' library
	PlayerResource:OnPlayerConnect(keys)
end

-- This function is called whenever illusions are created and tells you which was/is the original entity
function barebones:OnIllusionsCreated(keys)
	DebugPrint("[BAREBONES] OnIllusionsCreated")
	--PrintTable(keys)

	local original_entity = EntIndexToHScript(keys.original_entindex)
end

-- This function is called whenever an item is combined to create a new item
function barebones:OnItemCombined(keys)
	DebugPrint("[BAREBONES] OnItemCombined")
	--PrintTable(keys)

	-- The playerID of the hero that combined an item
	local playerID = keys.PlayerID
	if not playerID then
		return 
	end

	-- The name of the item that was combined
	local item_name = keys.itemname

	-- The cost of the item combined
	local item_cost = keys.itemcost
end

-- This function is called whenever an ability begins its PhaseStart phase (but before it is actually cast)
function barebones:OnAbilityCastBegins(keys)
	DebugPrint("[BAREBONES] OnAbilityCastBegins")
	--PrintTable(keys)

	local playerID = keys.PlayerID
	local ability_name = keys.abilityname

	-- If you need to adjust abilities on their cast, use Order Filter, not this
end

-- This function is called whenever a tower is destroyed
function barebones:OnTowerKill(keys)
	DebugPrint("[BAREBONES] OnTowerKill")
	--PrintTable(keys)

	local gold = keys.gold
	local killer_userID = keys.killer_userid
	local team = keys.teamnumber
end

-- This function is called whenever a player changes their custom team selection during Custom Game Setup 
function barebones:OnPlayerSelectedCustomTeam(keys)
	DebugPrint("[BAREBONES] OnPlayerSelectedCustomTeam")
	--PrintTable(keys)

	local playerID = keys.player_id
	local success = (keys.success == 1)
	local team = keys.team_id
end

-- This function is called whenever an NPC reaches its goal position/target (npc can be a lane creep)
function barebones:OnNPCGoalReached(keys)
	DebugPrint("[BAREBONES] OnNPCGoalReached")
	--PrintTable(keys)

	local goal_entity = EntIndexToHScript(keys.goal_entindex)
	local next_goal_entity = EntIndexToHScript(keys.next_goal_entindex)
	local npc = EntIndexToHScript(keys.npc_entindex)
end

-- This function is called whenever any player sends a chat message to team or to All
function barebones:OnPlayerChat(keys)
	DebugPrint("[BAREBONES] Player used the chat")
	--PrintTable(keys)

	local team_only = keys.teamonly
	local userID = keys.userid
	local team = keys.team
	local text = keys.text
	print(text)
	local team_num = PlayerResource:GetTeam(userID)
	print("Team "..team_num.. " typed a message")

	if team_num == 2 then 
		if (text == "no" or text == "NO" or text == "No") and _G.vote_to_concede_radiant == true then
		_G.vote_to_concede_radiant = false
		GameRules:SendCustomMessage("<font color='#dc143c'>Vote to surrender has been canceled!</font>", 0, 0)
		end
		if (text == "gg" or text == "GG" or text == "Good Game") and _G.radiant_can_concede == false then
		GameRules:SendCustomMessage("<font color='#dc143c'>You can only attempt to surrender 1 time per 2 minutes!</font>", 0, 0)
		end
		if (text == "gg" or text == "GG" or text == "Good Game") and _G.radiant_can_concede == true then
			GameRules:SendCustomMessage("<font color='#dc143c'>Radiant is Voting to Surrender! To cancel the vote type no (radiant only!)</font>", 0, 0)
			_G.vote_to_concede_radiant = true
			_G.radiant_can_concede = false
					Timers:CreateTimer(120, function()
      						_G.radiant_can_concede = true    
    				end)
		
    Timers:CreateTimer(10, function()
        if _G.vote_to_concede_radiant == true then
        	GameRules:SetGameWinner(3)
        end
        
    end)
end
end
	if team_num == 3 then 
		if (text == "no" or text == "NO" or text == "No") and _G.vote_to_concede_dire == true then
		_G.vote_to_concede_dire = false
		GameRules:SendCustomMessage("<font color='#dc143c'>Vote to surrender has been canceled!</font>", 0, 0)
		end
		if (text == "gg" or text == "GG" or text == "Good Game") and _G.dire_can_concede == false then
		GameRules:SendCustomMessage("<font color='#dc143c'>You can only attempt to surrender 1 time per 2 minutes!</font>", 0, 0)
		end
		if (text == "gg" or text == "GG" or text == "Good Game") and _G.dire_can_concede == true then
			GameRules:SendCustomMessage("<font color='#dc143c'>Dire is Voting to Surrender! To cancel the vote type no (radiant only!)</font>", 0, 0)
			_G.vote_to_concede_dire = true
			_G.dire_can_concede = false
					Timers:CreateTimer(120, function()
      						_G.dire_can_concede = true    
    				end)
			
		
    Timers:CreateTimer(10, function()
        if _G.vote_to_concede_dire == true then
        	GameRules:SetGameWinner(2)
        end
        
    end)



end
end
end
