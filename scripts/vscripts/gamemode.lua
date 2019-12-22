-- This is the primary barebones gamemode script and should be used to assist in initializing your game mode
BAREBONES_VERSION = "2.0.6"

-- Physics library can be used for advanced physics/motion/collision of units.  See PhysicsReadme.txt for more information.
require('libraries/physics')
-- Projectiles library can be used for advanced 3D projectile systems.
require('libraries/projectiles')
-- Notifications library can be used for sending panorama notifications to the UIs of players/teams/everyone
require('libraries/notifications')
-- Animations library can be used for starting customized animations on units from lua
require('libraries/animations')
-- Attachments library can be used for performing "Frankenstein" attachments on units
require('libraries/attachments')
-- PlayerTables library can be used to synchronize client-server data via player/client-specific net tables
require('libraries/playertables')
-- Selection library (by Noya) provides player selection inspection and management from server lua
require('libraries/selection')
require('libraries/notifications')

-- settings.lua is where you can specify many different properties for your game mode and is one of the core barebones files.
require('settings')
-- events.lua is where you can specify the actions to be taken when any event occurs and is one of the core barebones files.
require('events')
-- filters.lua
require('filters')

--[[
  This function should be used to set up Async precache calls at the beginning of the gameplay.

  In this function, place all of your PrecacheItemByNameAsync and PrecacheUnitByNameAsync.  These calls will be made
  after all players have loaded in, but before they have selected their heroes. PrecacheItemByNameAsync can also
  be used to precache dynamically-added datadriven abilities instead of items.  PrecacheUnitByNameAsync will 
  precache the precache{} block statement of the unit and all precache{} block statements for every Ability# 
  defined on the unit.

  This function should only be called once.  If you want to/need to precache more items/abilities/units at a later
  time, you can call the functions individually (for example if you want to precache units in a new wave of
  holdout).

  This function should generally only be used if the Precache() function in addon_game_mode.lua is not working.
]]
function barebones:PostLoadPrecache()
	DebugPrint("[BAREBONES] Performing Post-Load precache.")
	--PrecacheItemByNameAsync("item_example_item", function(...) end)
	--PrecacheItemByNameAsync("example_ability", function(...) end)

	--PrecacheUnitByNameAsync("npc_dota_hero_viper", function(...) end)
	--PrecacheUnitByNameAsync("npc_dota_hero_enigma", function(...) end)
end

--[[
  This function is called once and only once as soon as the first player (almost certain to be the server in local lobbies) loads in.
  It can be used to initialize state that isn't initializeable in InitGameMode() but needs to be done before everyone loads in.
]]
function barebones:OnFirstPlayerLoaded()
	DebugPrint("[BAREBONES] First Player has loaded.")

end

--[[
  This function is called once and only once after all players have loaded into the game, right as the hero selection time begins.
  It can be used to initialize non-hero player state or adjust the hero selection (i.e. force random etc)
]]
function barebones:OnAllPlayersLoaded()
	DebugPrint("[BAREBONES] All Players have loaded into the game.")

end

--[[
  This function is called once and only once for every player when they spawn into the game for the first time.  It is also called
  if the player's hero is replaced with a new hero for any reason.  This function is useful for initializing heroes, such as adding
  levels, changing the starting gold, removing/adding abilities, adding physics, etc.

  The hero parameter is the hero entity that just spawned in
]]
function barebones:OnHeroInGame(hero)

	-- Innate abilities (this is applied to bots and custom created heroes/illusions too)
	self:InitializeInnateAbilities(hero)

	Timers:CreateTimer(0.5, function()
		local playerID = hero:GetPlayerID()	-- never nil (-1 by default), needs delay 1 or more frames

		if PlayerResource:IsFakeClient(playerID) then
			-- This is happening only for bots
			DebugPrint("[BAREBONES] Bot hero "..hero:GetUnitName().." (re)spawned in the game.")
			-- Set starting gold for bots
			hero:SetGold(NORMAL_START_GOLD, false)
		else
			DebugPrint("[BAREBONES] OnHeroInGame running for a non-bot player!")
			if not PlayerResource.PlayerData[playerID] then
				PlayerResource.PlayerData[playerID] = {}
				DebugPrint("[BAREBONES] PlayerResource's PlayerData for playerID "..playerID.." was not properly initialized.")
			end
			-- Set some hero stuff on first spawn or on every spawn (custom or not)
			if PlayerResource.PlayerData[playerID].already_set_hero == true then
				-- This is happening only when players create new heroes with custom hero-create spells:
				-- Custom Illusion spells
			else
				-- This is happening for players when their primary hero spawns for the first time
				DebugPrint("[BAREBONES] Hero "..hero:GetUnitName().." spawned in the game for the first time for the player with ID "..playerID)

				-- Make heroes briefly visible on spawn (to prevent bad fog interactions)
				hero:MakeVisibleToTeam(DOTA_TEAM_GOODGUYS, 0.5)
				hero:MakeVisibleToTeam(DOTA_TEAM_BADGUYS, 0.5)

				-- Set the starting gold for the player's hero
				if PlayerResource:HasRandomed(playerID) then
					PlayerResource:ModifyGold(playerID, RANDOM_START_GOLD-600, false, 0)
				else
					-- If the NORMAL_START_GOLD is smaller then 600, remove Strategy Time and use SetGold
					PlayerResource:ModifyGold(playerID, NORMAL_START_GOLD-600, false, 0)
				end

				-- Create an item and add it to the player, effectively ensuring they start with the item
				if ADD_ITEM_TO_HERO_ON_SPAWN then
					local item = CreateItem("item_example_item", hero, hero)
					hero:AddItem(item)
				end
				local cmdplayer = Convars:GetCommandClient()
				local player = cmdplayer:GetAssignedHero()
				local playerlocation = player:GetAbsOrigin()
				local playerid = player:GetPlayerID()
				CreateUnitByName("npc_dota_courier", playerlocation, true, player, player, player:GetTeam()):SetControllableByPlayer(playerid, false)

				-- Make sure that stuff above will not happen again for the player if some other hero spawns
				-- for him for the first time during the game 
				PlayerResource.PlayerData[playerID].already_set_hero = true
				DebugPrint("[BAREBONES] Hero "..hero:GetUnitName().." set for the player with ID "..playerID)
			end
		end
	end)
end

--[[
  This function is called once and only once when the game completely begins (about 0:00 on the clock).  At this point,
  gold will begin to go up in ticks if configured, creeps will spawn, towers will become damageable etc.  This function
  is useful for starting any game logic timers/thinkers, beginning the first round, etc.
]]

function barebones:OnGameInProgress()
	DebugPrint("[BAREBONES] The game has officially begun.")
	
	CustomGameEventManager:Send_ServerToAllClients("setKillsToWin", {})
	Timers:CreateTimer(30, function()
	
	notifyDual30()
		return 600
	end)
		Timers:CreateTimer(45, function()
	
	notifyDual15()
		return 600
	end)

	Timers:CreateTimer(55, function()
	
	notifyDual5()
		return 600
	end)
	
	Timers:CreateTimer(60, function()
	
	EnterDual()
		return 600
	end)
	
	Timers:CreateTimer(180, function()
	
	ExitDual()
		return 600
	end)
	


function notifyDual30()
Notifications:TopToAll({text = "A duel will begin in 30 seconds!", duration=5.0})
EmitGlobalSound("ui.contract_complete")
end

function notifyDual15()
Notifications:TopToAll({text = "A duel will begin in 15 seconds!", duration=5.0})
EmitGlobalSound("ui.contract_complete")
end

function notifyDual5()
Notifications:TopToAll({text = "A duel will begin in 5 seconds!", duration=5.0})
EmitGlobalSound("ui.contract_complete")
end
	function EnterDual()
	_G.IsDual = true
	Notifications:TopToAll({text = "The duel has begun!", duration=5.0})
	EmitGlobalSound("ui.contract_complete")
	local trigger_out = Entities:FindByName(nil, "dual_keepout_trigger")
	local trigger_in = Entities:FindByName(nil, "dual_keepin_trigger")
	local rad_trigger_out = Entities:FindByNameNearest("dual_keepout_trigger", Entities:FindByName(nil, "radiant_spawn"):GetAbsOrigin(), 10000)
	trigger_out:Disable()
	trigger_in:Enable()
	rad_trigger_out:Disable()
	local players = HeroList:GetAllHeroes()
	local dHeroIncrementer = 0
	local rHeroIncrementer = 0
	local GetTotalDualPlayers = RandomInt(1,5)
	local GetArena = RandomInt(1,4)
	_G.arena1 = nil
	local arena1titan
	_G.arena1vs = nil
	local arena1titanvs
	_G.arena2 = nil
	_G.arena2vs = nil
	_G.DualArena1 = {}
	_G.DualArena2 = {}
	_G.DualArenavs1 = {}
	_G.DualArenavs2 = {}

		if GetArena == 1 then
			_G.arena1 = Entities:FindByName(nil, "dire_dual"):GetAbsOrigin()
			arena1titan = Entities:FindByName(nil, "dire_dual_titan"):GetAbsOrigin()
			_G.arena1vs = Entities:FindByName(nil, "dire_dual1"):GetAbsOrigin()
			arena1titanvs = Entities:FindByName(nil, "dire_dual_titan1"):GetAbsOrigin()
			_G.arena2 = Entities:FindByName(nil, "dire_dual2"):GetAbsOrigin()
			_G.arena2vs = Entities:FindByName(nil, "dire_dual3"):GetAbsOrigin()
		elseif GetArena == 2 then
			_G.arena1 = Entities:FindByName(nil, "dire_dual2"):GetAbsOrigin()
			arena1titan = Entities:FindByName(nil, "dire_dual_titan2"):GetAbsOrigin()
			_G.arena1vs = Entities:FindByName(nil, "dire_dual3"):GetAbsOrigin()
			arena1titanvs = Entities:FindByName(nil, "dire_dual_titan3"):GetAbsOrigin()
			_G.arena2 = Entities:FindByName(nil, "dire_dual"):GetAbsOrigin()
			_G.arena2vs = Entities:FindByName(nil, "dire_dual1"):GetAbsOrigin()
		elseif GetArena == 3 then
			_G.arena1 = Entities:FindByName(nil, "rad_dual"):GetAbsOrigin()
			arena1titan = Entities:FindByName(nil, "rad_dual_titan"):GetAbsOrigin()
			_G.arena1vs = Entities:FindByName(nil, "rad_dual1"):GetAbsOrigin()
			arena1titanvs = Entities:FindByName(nil, "rad_dual_titan1"):GetAbsOrigin()
			_G.arena2 = Entities:FindByName(nil, "rad_dual2"):GetAbsOrigin()
			_G.arena2vs = Entities:FindByName(nil, "rad_dual3"):GetAbsOrigin()
		else
			_G.arena1 = Entities:FindByName(nil, "rad_dual2"):GetAbsOrigin()
			arena1titan = Entities:FindByName(nil, "rad_dual_titan2"):GetAbsOrigin()
			_G.arena1vs = Entities:FindByName(nil, "rad_dual3"):GetAbsOrigin()
			arena1titanvs = Entities:FindByName(nil, "rad_dual_titan3"):GetAbsOrigin()
			_G.arena2 = Entities:FindByName(nil, "rad_dual"):GetAbsOrigin()
			_G.arena2vs = Entities:FindByName(nil, "rad_dual1"):GetAbsOrigin()
		end
			GameRules:SetHeroRespawnEnabled(false)
			for i, hero in pairs(players) do
				hero:SetBuyBackDisabledByReapersScythe(true)
				if rHeroIncrementer <= GetTotalDualPlayers then
				hero:AddNewModifier(hero, nil, "modifier_truesight", {duration=-1})
					if hero:GetTeamNumber() == 2 then
						FindClearSpaceForUnit(hero, _G.arena1, false)
						hero:AddNewModifier(hero, nil, "modifier_battle_cup_effigy", {duration=-1})
						hero:SetMana(hero:GetMaxMana())
						hero:SetHealth(hero:GetMaxHealth())
						SendToConsole("dota_camera_center")
						rHeroIncrementer = rHeroIncrementer + 1
						_G.DualArena1[i] = hero
					end
				end
				if dHeroIncrementer <= GetTotalDualPlayers then
				hero:AddNewModifier(hero, nil, "modifier_truesight", {duration=-1})
					if hero:GetTeamNumber() == 3 then
						FindClearSpaceForUnit(hero, _G.arena1vs, false)
						hero:AddNewModifier(hero, nil, "modifier_battle_cup_effigy", {duration=-1})
						hero:SetMana(hero:GetMaxMana())
						hero:SetHealth(hero:GetMaxHealth())
						SendToConsole("dota_camera_center")
						dHeroIncrementer = dHeroIncrementer + 1
						_G.DualArenavs1[i] = hero
					end
				end
					if dHeroIncrementer > GetTotalDualPlayers then
					hero:AddNewModifier(hero, nil, "modifier_truesight", {duration=-1})
						if hero:GetTeamNumber() == 3 then
							hero:AddNewModifier(hero, nil, "modifier_battle_cup_effigy", {duration=-1})
							hero:SetHealth(hero:GetMaxHealth())
							hero:SetMana(hero:GetMaxMana())
							FindClearSpaceForUnit(hero, _G.arena2vs, false)
							SendToConsole("dota_camera_center")
							_G.DualArena2[i] = hero
						end
					end
					if rHeroIncrementer > GetTotalDualPlayers then
					hero:AddNewModifier(hero, nil, "modifier_truesight", {duration=-1})
						if hero:GetTeamNumber() == 2 then
							hero:AddNewModifier(hero, nil, "modifier_battle_cup_effigy", {duration=-1})
							hero:SetHealth(hero:GetMaxHealth())
							hero:SetMana(hero:GetMaxMana())
							FindClearSpaceForUnit(hero, _G.arena2, false)
							SendToConsole("dota_camera_center")
							_G.DualArenavs2[i] = hero
						end
					end
				end
		local Creatures = Entities:FindAllByClassname("npc_dota_creature")
		for _, unit in ipairs(Creatures) do
			if unit:GetUnitName() == "npc_radiant_titan" then
				FindClearSpaceForUnit(unit, arena1titan, false)
				unit:MoveToPositionAggressive(arena1titanvs)
				break
			end
		end
		for _, unit in ipairs(Creatures) do
			if unit:GetUnitName() == "npc_dire_titan" then
				FindClearSpaceForUnit(unit, arena1titanvs, false)
				unit:MoveToPositionAggressive(arena1titan)
				break
			end
		end
	end
	
	function ExitDual()
	_G.IsDual = false
	for x=1, 11 do
		_G.DualArena1[x] = nil
		_G.DualArena2[x] = nil
		_G.DualArenavs1[x] = nil
		_G.DualArenavs2[x] = nil
	end
	local trigger_out = Entities:FindByNameNearest("dual_keepout_trigger", Entities:FindByName(nil, "dire_spawn"):GetAbsOrigin(), 10000)
	local rad_trigger_out = Entities:FindByNameNearest("dual_keepout_trigger", Entities:FindByName(nil, "radiant_spawn"):GetAbsOrigin(), 10000)
	local trigger_in = Entities:FindByName(nil, "dual_keepin_trigger")
	GameRules:SetHeroRespawnEnabled(true)
	local players = HeroList:GetAllHeroes()
		for _, hero in pairs(players) do
			hero:SetBuyBackDisabledByReapersScythe(false)
			hero:RemoveModifierByName("modifier_truesight")
			if hero:GetTeamNumber() == 2 then
				hero:Kill(nil, nil)
				hero:RespawnUnit()
				hero:RemoveModifierByName("modifier_truesight")
				FindClearSpaceForUnit(hero, Entities:FindByName(nil, "radiant_spawn"):GetAbsOrigin(), false)
				print(Entities:FindByName(nil, "radiant_spawn"):GetAbsOrigin())
				print(hero:GetAbsOrigin())
				SendToConsole("dota_camera_center")
			elseif hero:GetTeamNumber() == 3 then
				hero:Kill(nil, nil)
				hero:RespawnUnit()
				hero:RemoveModifierByName("modifier_truesight")
				FindClearSpaceForUnit(hero, Entities:FindByName(nil, "dire_spawn"):GetAbsOrigin(), false)
				SendToConsole("dota_camera_center")
			end
		end
		local Creatures = Entities:FindAllByClassname("npc_dota_creature")
		local radiant_titan_return = Entities:FindByName(nil, "rad_titan"):GetAbsOrigin()
		local dire_titan_return = Entities:FindByName(nil, "dire_titan"):GetAbsOrigin()
		for _, unit in ipairs(Creatures) do
			if unit:GetUnitName() == "npc_radiant_titan" then
				FindClearSpaceForUnit(unit, radiant_titan_return, false)
				unit:Stop()
				break
			end
		end
		for _, unit in ipairs(Creatures) do
			if unit:GetUnitName() == "npc_dire_titan" then
				FindClearSpaceForUnit(unit, dire_titan_return, false)
				unit:Stop()
				break
			end
		end
		
		trigger_out:Enable()
		rad_trigger_out:Enable()
		trigger_in:Disable()
	end
	
	
	Timers:CreateTimer(0, function()
	
	SpawnTitans()
		return 600
		
	end)
	level = 0
function SpawnTitans(keys)
	local Creatures = Entities:FindAllByClassname("npc_dota_creature")
	local radtitan = false
	local badtitan = false
	for _, unit in ipairs(Creatures) do
		if unit:GetUnitName() == "npc_radiant_titan" then
			radtitan = true
			break
		end
	end
	for _, unit in ipairs(Creatures) do
		if unit:GetUnitName() == "npc_dire_titan" then
			badtitan = true
			break
		end
	end
	if radtitan == false then
		CreateUnitByName("npc_radiant_titan", Entities:FindByName(nil, "rad_titan"):GetAbsOrigin(), true, nil, nil, 2):CreatureLevelUp(level)
	end
	if badtitan == false then
		CreateUnitByName("npc_dire_titan", Entities:FindByName(nil, "dire_titan"):GetAbsOrigin(), true, nil, nil, 3):CreatureLevelUp(level)
	end
end
	Timers:CreateTimer(30, function() -- Start this timer 30 game-time seconds later
    
	SpawnCreeps()
      return 120 -- Rerun this timer every 120 game-time seconds 
	  
    end)

function SpawnCreeps(keys)
	
local Creatures = Entities:FindAllByClassname("npc_dota_creature")
	for _, unit in ipairs(Creatures) do
		if unit:GetUnitName() == "npc_radiant_titan" then
			local hp = unit:GetHealth()
			local mp = unit:GetMana()
			unit:CreatureLevelUp(1)
			unit:SetHealth(hp)
			unit:SetMana(mp)
			break
		end
	end
	for _, unit in ipairs(Creatures) do
		if unit:GetUnitName() == "npc_dire_titan" then
			local hp = unit:GetHealth()
			local mp = unit:GetMana()
			unit:CreatureLevelUp(1)
			unit:SetHealth(hp)
			unit:SetMana(mp)
			break
		end
	end

	local e1 = "npc_easy_ghost_b"
	local e2 = "npc_easy_forest_troll_berserker"
	local e3 = "npc_easy_frost_kobold"
	local e4 = "npc_easy_satyr_b"
	local e5 = "npc_easy_beast"
	local m1 = "npc_med_harpy_b"
	local m2 = "npc_med_kobold_a"
	local m3 = "npc_med_vulture_a"
	local m4 = "npc_med_frost_gnoll"
	local h1 = "npc_hard_ghost_a"
	local h2 = "npc_hard_eimermole"
	local h3 = "npc_hard_satyr_a"
	local h4 = "npc_hard_gargoyle_jungle_stalker"
	local a1 = "npc_ancient_troll_dark_frost"
	local a2 = "npc_ancient_dragonspawn_b"
	local a3 = "npc_ancient_frost_ghost"
	local loc = Entities:FindByName(nil, "rad_n_easy"):GetAbsOrigin()
	local loc1 = Entities:FindByName(nil, "rad_n_easy1"):GetAbsOrigin()
	local badloc = Entities:FindByName(nil, "dire_n_easy"):GetAbsOrigin()
	local badloc1 = Entities:FindByName(nil, "dire_n_easy1"):GetAbsOrigin()
	local mloc = Entities:FindByName(nil, "rad_n_medium"):GetAbsOrigin()
	local mloc1 = Entities:FindByName(nil, "rad_n_medium1"):GetAbsOrigin()
	local mloc2 = Entities:FindByName(nil, "rad_n_medium2"):GetAbsOrigin()
	local mloc3 = Entities:FindByName(nil, "rad_n_medium3"):GetAbsOrigin()
	local mbadloc = Entities:FindByName(nil, "dire_n_medium"):GetAbsOrigin()
	local mbadloc1 = Entities:FindByName(nil, "dire_n_medium1"):GetAbsOrigin()
	local mbadloc2 = Entities:FindByName(nil, "dire_n_medium2"):GetAbsOrigin()
	local mbadloc3 = Entities:FindByName(nil, "dire_n_medium3"):GetAbsOrigin()
	local hloc = Entities:FindByName(nil, "rad_n_hard"):GetAbsOrigin()
	local hloc1 = Entities:FindByName(nil, "rad_n_hard1"):GetAbsOrigin()
	local hloc2 = Entities:FindByName(nil, "rad_n_hard2"):GetAbsOrigin()
	local hloc3 = Entities:FindByName(nil, "rad_n_hard3"):GetAbsOrigin()
	local hbadloc = Entities:FindByName(nil, "dire_n_hard"):GetAbsOrigin()
	local hbadloc1 = Entities:FindByName(nil, "dire_n_hard1"):GetAbsOrigin()
	local hbadloc2 = Entities:FindByName(nil, "dire_n_hard2"):GetAbsOrigin()
	local hbadloc3 = Entities:FindByName(nil, "dire_n_hard3"):GetAbsOrigin()
	local aloc = Entities:FindByName(nil, "rad_n_ancient"):GetAbsOrigin()
	local aloc1 = Entities:FindByName(nil, "rad_n_ancient1"):GetAbsOrigin()
	local abadloc = Entities:FindByName(nil, "dire_n_ancient"):GetAbsOrigin()
	local abadloc1 = Entities:FindByName(nil, "dire_n_ancient1"):GetAbsOrigin()
	
	for e=1, 7 do
	local randint = RandomInt(1,5)
	 if randint == 1 then
		CreateUnitByName(e1, loc, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(e1, loc1, true, nil, nil, 4):CreatureLevelUp(level)
	elseif randint == 2 then
		CreateUnitByName(e2, loc, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(e2, loc1, true, nil, nil, 4):CreatureLevelUp(level)
	elseif randint == 3 then
		CreateUnitByName(e3, loc, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(e3, loc1, true, nil, nil, 4):CreatureLevelUp(level)
	elseif randint == 4 then
		CreateUnitByName(e4, loc, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(e4, loc1, true, nil, nil, 4):CreatureLevelUp(level)
	elseif randint == 5 then
		CreateUnitByName(e5, loc, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(e5, loc1, true, nil, nil, 4):CreatureLevelUp(level)
	end
	if randint == 1 then
		CreateUnitByName(e1, badloc, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(e1, badloc1, true, nil, nil, 4):CreatureLevelUp(level)
	elseif randint == 2 then
		CreateUnitByName(e2, badloc, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(e2, badloc1, true, nil, nil, 4):CreatureLevelUp(level)
	elseif randint == 3 then
		CreateUnitByName(e3, badloc, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(e3, badloc1, true, nil, nil, 4):CreatureLevelUp(level)
	elseif randint == 4 then
		CreateUnitByName(e4, badloc, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(e4, badloc1, true, nil, nil, 4):CreatureLevelUp(level)
	elseif randint == 5 then
		CreateUnitByName(e5, badloc, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(e5, badloc1, true, nil, nil, 4):CreatureLevelUp(level)
	end
	end
	for m=1, 7 do
	local randint = RandomInt(1,4)
	 if randint == 1 then
		CreateUnitByName(m1, mloc, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(m1, mloc1, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(m1, mloc2, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(m1, mloc3, true, nil, nil, 4):CreatureLevelUp(level)
	elseif randint == 2 then
		CreateUnitByName(m2, mloc, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(m2, mloc1, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(m2, mloc2, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(m2, mloc3, true, nil, nil, 4):CreatureLevelUp(level)
	elseif randint == 3 then
		CreateUnitByName(m3, mloc, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(m3, mloc1, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(m3, mloc2, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(m3, mloc3, true, nil, nil, 4):CreatureLevelUp(level)
	elseif randint == 4 then
		CreateUnitByName(m4, mloc, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(m4, mloc1, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(m4, mloc2, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(m4, mloc3, true, nil, nil, 4):CreatureLevelUp(level)
	end
	if randint == 1 then
		CreateUnitByName(m1, mbadloc, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(m1, mbadloc1, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(m1, mbadloc2, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(m1, mbadloc3, true, nil, nil, 4):CreatureLevelUp(level)
		
	elseif randint == 2 then
		CreateUnitByName(m2, mbadloc, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(m2, mbadloc1, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(m2, mbadloc2, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(m2, mbadloc3, true, nil, nil, 4):CreatureLevelUp(level)
		
	elseif randint == 3 then
		CreateUnitByName(m3, mbadloc, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(m3, mbadloc1, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(m3, mbadloc2, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(m3, mbadloc3, true, nil, nil, 4):CreatureLevelUp(level)
		
	elseif randint == 4 then
		CreateUnitByName(m4, mbadloc, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(m4, mbadloc1, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(m4, mbadloc2, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(m4, mbadloc3, true, nil, nil, 4):CreatureLevelUp(level)
		
	end
	end
	for h=1, 7 do
	local randint = RandomInt(1,4)
	 if randint == 1 then
		CreateUnitByName(h1, hloc, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(h1, hloc1, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(h1, hloc2, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(h1, hloc3, true, nil, nil, 4):CreatureLevelUp(level)
	elseif randint == 2 then
		CreateUnitByName(h2, hloc, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(h2, hloc1, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(h2, hloc2, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(h2, hloc3, true, nil, nil, 4):CreatureLevelUp(level)
	elseif randint == 3 then
		CreateUnitByName(h3, hloc, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(h3, hloc1, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(h3, hloc2, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(h3, hloc3, true, nil, nil, 4):CreatureLevelUp(level)
	elseif randint == 4 then
		CreateUnitByName(h4, hloc, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(h4, hloc1, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(h4, hloc2, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(h4, hloc3, true, nil, nil, 4):CreatureLevelUp(level)
	end
	if randint == 1 then
		CreateUnitByName(h1, hbadloc, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(h1, hbadloc1, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(h1, hbadloc2, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(h1, hbadloc3, true, nil, nil, 4):CreatureLevelUp(level)
	elseif randint == 2 then
		CreateUnitByName(h2, hbadloc, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(h2, hbadloc1, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(h2, hbadloc2, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(h2, hbadloc3, true, nil, nil, 4):CreatureLevelUp(level)
	elseif randint == 3 then
		CreateUnitByName(h3, hbadloc, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(h3, hbadloc1, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(h3, hbadloc2, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(h3, hbadloc3, true, nil, nil, 4):CreatureLevelUp(level)
	elseif randint == 4 then
		CreateUnitByName(h4, hbadloc, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(h4, hbadloc1, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(h4, hbadloc2, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(h4, hbadloc3, true, nil, nil, 4):CreatureLevelUp(level)
	end
	end
	for a=1, 7 do
	local randint = RandomInt(1,3)
	 if randint == 1 then
		CreateUnitByName(a1, aloc, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(a1, aloc1, true, nil, nil, 4):CreatureLevelUp(level)
	elseif randint == 2 then
		CreateUnitByName(a2, aloc, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(a2, aloc1, true, nil, nil, 4):CreatureLevelUp(level)
	elseif randint == 3 then
		CreateUnitByName(a3, aloc, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(a3, aloc1, true, nil, nil, 4):CreatureLevelUp(level)
	end
	if randint == 1 then
		CreateUnitByName(a1, abadloc, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(a1, abadloc1, true, nil, nil, 4):CreatureLevelUp(level)
	elseif randint == 2 then
		CreateUnitByName(a2, abadloc, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(a2, abadloc1, true, nil, nil, 4):CreatureLevelUp(level)
	elseif randint == 3 then
		CreateUnitByName(a3, abadloc, true, nil, nil, 4):CreatureLevelUp(level)
		CreateUnitByName(a3, abadloc1, true, nil, nil, 4):CreatureLevelUp(level)
	end
	end
	level = level + 1
end
end

-- This function initializes the game mode and is called before anyone loads into the game
-- It can be used to pre-initialize any values/tables that will be needed later
function barebones:InitGameMode()
	DebugPrint("[BAREBONES] Starting to load Game Rules.")
	GameRules.DropTable = LoadKeyValues("scripts/vscripts/droptables.kv")
	-- Setup rules
	GameRules:SetHeroRespawnEnabled(ENABLE_HERO_RESPAWN)
	GameRules:SetUseUniversalShopMode(UNIVERSAL_SHOP_MODE)
	GameRules:SetSameHeroSelectionEnabled(ALLOW_SAME_HERO_SELECTION)

	GameRules:SetHeroSelectionTime(HERO_SELECTION_TIME) --THIS IS IGNORED when "EnablePickRules" is "1" in 'addoninfo.txt' !
	GameRules:SetHeroSelectPenaltyTime(HERO_SELECTION_PENALTY_TIME)
	
	GameRules:SetPreGameTime(PRE_GAME_TIME)
	GameRules:SetPostGameTime(POST_GAME_TIME)
	GameRules:SetShowcaseTime(SHOWCASE_TIME)
	GameRules:SetStrategyTime(STRATEGY_TIME)

	GameRules:SetTreeRegrowTime(TREE_REGROW_TIME)

	if USE_CUSTOM_HERO_LEVELS then
		GameRules:SetUseCustomHeroXPValues(true)
	end

	GameRules:SetGoldPerTick(GOLD_PER_TICK)
	GameRules:SetGoldTickTime(GOLD_TICK_TIME)
	GameRules:SetStartingGold(NORMAL_START_GOLD) -- Not sure if it works

	if USE_CUSTOM_HERO_GOLD_BOUNTY then
		GameRules:SetUseBaseGoldBountyOnHeroes(false)
	end

	GameRules:SetHeroMinimapIconScale(MINIMAP_ICON_SIZE)
	GameRules:SetCreepMinimapIconScale(MINIMAP_CREEP_ICON_SIZE)
	GameRules:SetRuneMinimapIconScale(MINIMAP_RUNE_ICON_SIZE)
	GameRules:SetFirstBloodActive(ENABLE_FIRST_BLOOD)
	GameRules:SetHideKillMessageHeaders(HIDE_KILL_BANNERS)
	GameRules:LockCustomGameSetupTeamAssignment(LOCK_TEAMS)

	-- This is multi-team configuration stuff
	if GetMapName() == "5v5" then
		GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_GOODGUYS, 5)
		GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_BADGUYS, 5)
	end

	if USE_CUSTOM_TEAM_COLORS then
		for team,color in pairs(TEAM_COLORS) do
			SetTeamCustomHealthbarColor(team, color[1], color[2], color[3])
		end
	end

	DebugPrint("[BAREBONES] Done with setting Game Rules.")

	-- Event Hooks / Listeners
	ListenToGameEvent('dota_player_gained_level', Dynamic_Wrap(barebones, 'OnPlayerLevelUp'), self)
	ListenToGameEvent('dota_ability_channel_finished', Dynamic_Wrap(barebones, 'OnAbilityChannelFinished'), self)
	ListenToGameEvent('dota_player_learned_ability', Dynamic_Wrap(barebones, 'OnPlayerLearnedAbility'), self)
	ListenToGameEvent('entity_killed', Dynamic_Wrap(barebones, 'OnEntityKilled'), self)
	ListenToGameEvent('player_connect_full', Dynamic_Wrap(barebones, 'OnConnectFull'), self)
	ListenToGameEvent('player_disconnect', Dynamic_Wrap(barebones, 'OnDisconnect'), self)
	ListenToGameEvent('dota_item_purchased', Dynamic_Wrap(barebones, 'OnItemPurchased'), self)
	ListenToGameEvent('dota_item_picked_up', Dynamic_Wrap(barebones, 'OnItemPickedUp'), self)
	ListenToGameEvent('last_hit', Dynamic_Wrap(barebones, 'OnLastHit'), self)
	ListenToGameEvent('dota_non_player_used_ability', Dynamic_Wrap(barebones, 'OnNonPlayerUsedAbility'), self)
	ListenToGameEvent('player_changename', Dynamic_Wrap(barebones, 'OnPlayerChangedName'), self)
	ListenToGameEvent('dota_rune_activated_server', Dynamic_Wrap(barebones, 'OnRuneActivated'), self)
	ListenToGameEvent('dota_player_take_tower_damage', Dynamic_Wrap(barebones, 'OnPlayerTakeTowerDamage'), self)
	ListenToGameEvent('tree_cut', Dynamic_Wrap(barebones, 'OnTreeCut'), self)

	ListenToGameEvent('dota_player_used_ability', Dynamic_Wrap(barebones, 'OnAbilityUsed'), self)
	ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(barebones, 'OnGameRulesStateChange'), self)
	ListenToGameEvent('npc_spawned', Dynamic_Wrap(barebones, 'OnNPCSpawned'), self)
	ListenToGameEvent('dota_player_pick_hero', Dynamic_Wrap(barebones, 'OnPlayerPickHero'), self)
	ListenToGameEvent('dota_team_kill_credit', Dynamic_Wrap(barebones, 'OnTeamKillCredit'), self)
	ListenToGameEvent("player_reconnected", Dynamic_Wrap(barebones, 'OnPlayerReconnect'), self)
	ListenToGameEvent("player_chat", Dynamic_Wrap(barebones, 'OnPlayerChat'), self)

	ListenToGameEvent("dota_illusions_created", Dynamic_Wrap(barebones, 'OnIllusionsCreated'), self)
	ListenToGameEvent("dota_item_combined", Dynamic_Wrap(barebones, 'OnItemCombined'), self)
	ListenToGameEvent("dota_player_begin_cast", Dynamic_Wrap(barebones, 'OnAbilityCastBegins'), self)
	ListenToGameEvent("dota_tower_kill", Dynamic_Wrap(barebones, 'OnTowerKill'), self)
	ListenToGameEvent("dota_player_selected_custom_team", Dynamic_Wrap(barebones, 'OnPlayerSelectedCustomTeam'), self)
	ListenToGameEvent("dota_npc_goal_reached", Dynamic_Wrap(barebones, 'OnNPCGoalReached'), self)

	-- Change random seed for math.random function
	local timeTxt = string.gsub(string.gsub(GetSystemTime(), ':', ''), '0','')
	math.randomseed(tonumber(timeTxt))

	DebugPrint("[BAREBONES] Setting filters.")

	local gamemode = GameRules:GetGameModeEntity()

	-- Setting the Order filter 
	gamemode:SetExecuteOrderFilter(Dynamic_Wrap(barebones, "OrderFilter"), self)

	-- Setting the Damage filter
	gamemode:SetDamageFilter(Dynamic_Wrap(barebones, "DamageFilter"), self)

	-- Setting the Modifier filter
	gamemode:SetModifierGainedFilter(Dynamic_Wrap(barebones, "ModifierFilter"), self)

	-- Setting the Experience filter
	gamemode:SetModifyExperienceFilter(Dynamic_Wrap(barebones, "ExperienceFilter"), self)

	-- Setting the Tracking Projectile filter
	gamemode:SetTrackingProjectileFilter(Dynamic_Wrap(barebones, "ProjectileFilter"), self)

	-- Setting the rune spawn filter
	gamemode:SetRuneSpawnFilter(Dynamic_Wrap(barebones, "RuneSpawnFilter"), self)

	-- Setting the bounty rune pickup filter
	gamemode:SetBountyRunePickupFilter(Dynamic_Wrap(barebones, "BountyRuneFilter"), self)

	-- Setting the Healing filter
	gamemode:SetHealingFilter(Dynamic_Wrap(barebones, "HealingFilter"), self)

	-- Setting the Gold Filter
	gamemode:SetModifyGoldFilter(Dynamic_Wrap(barebones, "GoldFilter"), self)

	-- Setting the Inventory filter
	gamemode:SetItemAddedToInventoryFilter(Dynamic_Wrap(barebones, "InventoryFilter"), self)

	DebugPrint("[BAREBONES] Done with setting Filters.")

	-- Global Lua Modifiers
	LinkLuaModifier("modifier_custom_invulnerable", "modifiers/modifier_custom_invulnerable", LUA_MODIFIER_MOTION_NONE)

	-- Talent modifiers (this can be done in ability scripts, but it can be done here as well)
	LinkLuaModifier("modifier_ability_name_talent_name_1", "modifiers/talents/modifier_ability_name_talent_name_1", LUA_MODIFIER_MOTION_NONE)
	LinkLuaModifier("modifier_ability_name_talent_name_2", "modifiers/talents/modifier_ability_name_talent_name_2", LUA_MODIFIER_MOTION_NONE)
	LinkLuaModifier("modifier_ability_name_talent_name_3", "modifiers/talents/modifier_ability_name_talent_name_3", LUA_MODIFIER_MOTION_NONE)

	print("[BAREBONES] initialized.")
	DebugPrint("[BAREBONES] Done loading the game mode!\n\n")
	
	-- Increase/decrease maximum item limit per hero
	Convars:SetInt('dota_max_physical_items_purchase_limit', 64)
end

-- This function is called as the first player loads and sets up the game mode parameters
function barebones:CaptureGameMode()
	local gamemode = GameRules:GetGameModeEntity()
	
	-- Set GameMode parameters
	gamemode:SetRecommendedItemsDisabled(RECOMMENDED_BUILDS_DISABLED)
	gamemode:SetCameraDistanceOverride(CAMERA_DISTANCE_OVERRIDE)
	gamemode:SetBuybackEnabled(BUYBACK_ENABLED)
	gamemode:SetCustomBuybackCostEnabled(CUSTOM_BUYBACK_COST_ENABLED)
	gamemode:SetCustomBuybackCooldownEnabled(CUSTOM_BUYBACK_COOLDOWN_ENABLED)
	gamemode:SetTopBarTeamValuesOverride(USE_CUSTOM_TOP_BAR_VALUES)
	gamemode:SetTopBarTeamValuesVisible(TOP_BAR_VISIBLE)

	if USE_CUSTOM_XP_VALUES then
		gamemode:SetUseCustomHeroLevels(true)
		gamemode:SetCustomXPRequiredToReachNextLevel(XP_PER_LEVEL_TABLE)
	end

	gamemode:SetBotThinkingEnabled(USE_STANDARD_DOTA_BOT_THINKING)
	gamemode:SetTowerBackdoorProtectionEnabled(ENABLE_TOWER_BACKDOOR_PROTECTION)

	gamemode:SetFogOfWarDisabled(DISABLE_FOG_OF_WAR_ENTIRELY)
	gamemode:SetGoldSoundDisabled(DISABLE_GOLD_SOUNDS)
	--gamemode:SetRemoveIllusionsOnDeath(REMOVE_ILLUSIONS_ON_DEATH)

	gamemode:SetAlwaysShowPlayerInventory(SHOW_ONLY_PLAYER_INVENTORY)
	gamemode:SetAnnouncerDisabled(DISABLE_ANNOUNCER)
	if FORCE_PICKED_HERO ~= nil then
		gamemode:SetCustomGameForceHero(FORCE_PICKED_HERO) -- THIS WILL NOT WORK when "EnablePickRules" is "1" in 'addoninfo.txt' !
	else
		gamemode:SetDraftingBanningTimeOverride(BANNING_PHASE_TIME)
		gamemode:SetDraftingHeroPickSelectTimeOverride(HERO_SELECTION_TIME)
	end
	gamemode:SetFixedRespawnTime(FIXED_RESPAWN_TIME)
	gamemode:SetFountainConstantManaRegen(FOUNTAIN_CONSTANT_MANA_REGEN)
	gamemode:SetFountainPercentageHealthRegen(FOUNTAIN_PERCENTAGE_HEALTH_REGEN)
	gamemode:SetFountainPercentageManaRegen(FOUNTAIN_PERCENTAGE_MANA_REGEN)
	gamemode:SetLoseGoldOnDeath(LOSE_GOLD_ON_DEATH)
	gamemode:SetMaximumAttackSpeed(MAXIMUM_ATTACK_SPEED)
	gamemode:SetMinimumAttackSpeed(MINIMUM_ATTACK_SPEED)
	gamemode:SetStashPurchasingDisabled(DISABLE_STASH_PURCHASING)

	if USE_DEFAULT_RUNE_SYSTEM then
		gamemode:SetUseDefaultDOTARuneSpawnLogic(USE_DEFAULT_RUNE_SYSTEM)
	else
		-- Most runes are broken by Valve, if they don't fix them: use RuneSpawnFilter
		for rune, spawn in pairs(ENABLED_RUNES) do
			gamemode:SetRuneEnabled(rune, spawn)
		end
		gamemode:SetBountyRuneSpawnInterval(BOUNTY_RUNE_SPAWN_INTERVAL)
		gamemode:SetPowerRuneSpawnInterval(POWER_RUNE_SPAWN_INTERVAL)
	end

	gamemode:SetUnseenFogOfWarEnabled(USE_UNSEEN_FOG_OF_WAR)
	gamemode:SetDaynightCycleDisabled(DISABLE_DAY_NIGHT_CYCLE)
	gamemode:SetKillingSpreeAnnouncerDisabled(DISABLE_KILLING_SPREE_ANNOUNCER)
	gamemode:SetStickyItemDisabled(DISABLE_STICKY_ITEM)
	gamemode:SetPauseEnabled(ENABLE_PAUSING)
	gamemode:SetCustomScanCooldown(CUSTOM_SCAN_COOLDOWN)

	self:OnFirstPlayerLoaded()
end

-- Initializes heroes' innate abilities (abilities that a hero needs to have auto-leveled up at the start of the game)
function barebones:InitializeInnateAbilities(hero)

	-- List of all innate abilities
	local innate_abilities = {
		"detonator_conjure_image",
		"innate_ability2"
	}

	-- Cycle through any innate abilities found, then set their level to 1
	for i = 1, #innate_abilities do
		local current_ability = hero:FindAbilityByName(innate_abilities[i])
		if current_ability then
			current_ability:SetLevel(1)
		end
	end
end
