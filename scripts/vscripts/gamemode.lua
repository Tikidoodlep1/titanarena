-- This is the primary barebones gamemode script and should be used to assist in initializing your game mode
BAREBONES_VERSION = "1.00"

-- Set this to true if you want to see a complete debug output of all events/processes done by barebones
-- You can also change the cvar 'barebones_spew' at any time to 1 or 0 for output/no output
BAREBONES_DEBUG_SPEW = false 

if GameMode == nil then
    DebugPrint( '[BAREBONES] creating barebones game mode' )
    _G.GameMode = class({})
end

-- This library allow for easily delayed/timed actions
require('libraries/timers')
-- This library can be used for advancted physics/motion/collision of units.  See PhysicsReadme.txt for more information.
require('libraries/physics')
-- This library can be used for advanced 3D projectile systems.
require('libraries/projectiles')
-- This library can be used for sending panorama notifications to the UIs of players/teams/everyone
require('libraries/notifications')
-- This library can be used for starting customized animations on units from lua
require('libraries/animations')
-- This library can be used for performing "Frankenstein" attachments on units
require('libraries/attachments')
-- This library can be used to synchronize client-server data via player/client-specific nettables
require('libraries/playertables')
-- This library can be used to create container inventories or container shops
			--require('libraries/containers')
-- This library provides a searchable, automatically updating lua API in the tools-mode via "modmaker_api" console command
require('libraries/modmaker')
-- This library provides an automatic graph construction of path_corner entities within the map
require('libraries/pathgraph')
-- This library (by Noya) provides player selection inspection and management from server lua
require('libraries/selection')

-- These internal libraries set up barebones's events and processes.  Feel free to inspect them/change them if you need to.
require('internal/gamemode')
require('internal/events')

-- settings.lua is where you can specify many different properties for your game mode and is one of the core barebones files.
require('settings')
-- events.lua is where you can specify the actions to be taken when any event occurs and is one of the core barebones files.
require('events')


-- This is a detailed example of many of the containers.lua possibilities, but only activates if you use the provided "playground" map
if GetMapName() == "playground" then
  require("examples/playground")
end

--require("examples/worldpanelsExample")

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
function GameMode:PostLoadPrecache()
  DebugPrint("[BAREBONES] Performing Post-Load precache")    
  --PrecacheItemByNameAsync("item_example_item", function(...) end)
  --PrecacheItemByNameAsync("example_ability", function(...) end)

  --PrecacheUnitByNameAsync("npc_dota_hero_viper", function(...) end)
  --PrecacheUnitByNameAsync("npc_dota_hero_enigma", function(...) end)
end

--[[
  This function is called once and only once as soon as the first player (almost certain to be the server in local lobbies) loads in.
  It can be used to initialize state that isn't initializeable in InitGameMode() but needs to be done before everyone loads in.
]]
function GameMode:OnFirstPlayerLoaded()
  DebugPrint("[BAREBONES] First Player has loaded")
end

--[[
  This function is called once and only once after all players have loaded into the game, right as the hero selection time begins.
  It can be used to initialize non-hero player state or adjust the hero selection (i.e. force random etc)
]]
function GameMode:OnAllPlayersLoaded()
  DebugPrint("[BAREBONES] All Players have loaded into the game")
end

--[[
  This function is called once and only once for every player when they spawn into the game for the first time.  It is also called
  if the player's hero is replaced with a new hero for any reason.  This function is useful for initializing heroes, such as adding
  levels, changing the starting gold, removing/adding abilities, adding physics, etc.

  The hero parameter is the hero entity that just spawned in
]]
function GameMode:OnHeroInGame(hero)
  DebugPrint("[BAREBONES] Hero spawned in game for first time -- " .. hero:GetUnitName())

  -- This line for example will set the starting gold of every hero to 500 unreliable gold
  --hero:SetGold(500, false)

  -- These lines will create an item and add it to the player, effectively ensuring they start with the item

  --[[ --These lines if uncommented will replace the W ability of any hero that loads into the game
    --with the "example_ability" ability

  local abil = hero:GetAbilityByIndex(1)
  hero:RemoveAbility(abil:GetAbilityName())
  hero:AddAbility("example_ability")]]
end

--[[
  This function is called once and only once when the game completely begins (about 0:00 on the clock).  At this point,
  gold will begin to go up in ticks if configured, creeps will spawn, towers will become damageable etc.  This function
  is useful for starting any game logic timers/thinkers, beginning the first round, etc.
]]
function GameMode:OnGameInProgress()
  DebugPrint("[BAREBONES] The game has officially begun")

  Timers:CreateTimer(30, -- Start this timer 30 game-time seconds later
    function(SpawnCreeps)
      return 120.0 -- Rerun this timer every 120 game-time seconds 
    end)
	
	function SpawnCreeps(keys)
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
	local badloc = Entities:FindByName(nil, "dire_n_easy"):GetAbsOrigin()
	local mloc = Entities:FindByName(nil, "rad_n_medium"):GetAbsOrigin()
	local mbadloc = Entities:FindByName(nil, "dire_n_medium"):GetAbsOrigin()
	local hloc = Entities:FindByName(nil, "rad_n_hard"):GetAbsOrigin()
	local hbadloc = Entities:FindByName(nil, "dire_n_hard"):GetAbsOrigin()
	local aloc = Entities:FindByName(nil, "rad_n_ancient"):GetAbsOrigin()
	local abadloc = Entities:FindByName(nil, "dire_n_ancient"):GetAbsOrigin()
	for e=1, 7 do
	local randint = RandomInt(1,5)
	 if randint == 1 then
		CreateUnitByName(e1, loc, true, nil, nil, 3)
	elseif randint == 2 then
		CreateUnitByName(e2, loc, true, nil, nil, 3)
	elseif randint == 3 then
		CreateUnitByName(e3, loc, true, nil, nil, 3)
	elseif randint == 4 then
		CreateUnitByName(e4, loc, true, nil, nil, 3)
	elseif randint == 5 then
		CreateUnitByName(e5, loc, true, nil, nil, 3)
	end
	if randint == 1 then
		CreateUnitByName(e1, badloc, true, nil, nil, 3)
	elseif randint == 2 then
		CreateUnitByName(e2, badloc, true, nil, nil, 3)
	elseif randint == 3 then
		CreateUnitByName(e3, badloc, true, nil, nil, 3)
	elseif randint == 4 then
		CreateUnitByName(e4, badloc, true, nil, nil, 3)
	elseif randint == 5 then
		CreateUnitByName(e5, badloc, true, nil, nil, 3)
	end
	end
	for m=1, 7 do
	local randint = RandomInt(1,4)
	 if randint == 1 then
		CreateUnitByName(m1, mloc, true, nil, nil, 3)
	elseif randint == 2 then
		CreateUnitByName(m2, mloc, true, nil, nil, 3)
	elseif randint == 3 then
		CreateUnitByName(m3, mloc, true, nil, nil, 3)
	elseif randint == 4 then
		CreateUnitByName(m4, mloc, true, nil, nil, 3)
	end
	if randint == 1 then
		CreateUnitByName(m1, mbadloc, true, nil, nil, 3)
	elseif randint == 2 then
		CreateUnitByName(m2, mbadloc, true, nil, nil, 3)
	elseif randint == 3 then
		CreateUnitByName(m3, mbadloc, true, nil, nil, 3)
	elseif randint == 4 then
		CreateUnitByName(m4, mbadloc, true, nil, nil, 3)
	end
	end
	for h=1, 7 do
	local randint = RandomInt(1,4)
	 if randint == 1 then
		CreateUnitByName(h1, hloc, true, nil, nil, 3)
	elseif randint == 2 then
		CreateUnitByName(h2, hloc, true, nil, nil, 3)
	elseif randint == 3 then
		CreateUnitByName(h3, hloc, true, nil, nil, 3)
	elseif randint == 4 then
		CreateUnitByName(h4, hloc, true, nil, nil, 3)
	end
	if randint == 1 then
		CreateUnitByName(h1, hbadloc, true, nil, nil, 3)
	elseif randint == 2 then
		CreateUnitByName(h2, hbadloc, true, nil, nil, 3)
	elseif randint == 3 then
		CreateUnitByName(h3, hbadloc, true, nil, nil, 3)
	elseif randint == 4 then
		CreateUnitByName(h4, hbadloc, true, nil, nil, 3)
	end
	end
	for a=1, 7 do
	local randint = RandomInt(1,3)
	 if randint == 1 then
		CreateUnitByName(a1, aloc, true, nil, nil, 3)
	elseif randint == 2 then
		CreateUnitByName(a2, aloc, true, nil, nil, 3)
	elseif randint == 3 then
		CreateUnitByName(a3, aloc, true, nil, nil, 3)
	end
	if randint == 1 then
		CreateUnitByName(a1, abadloc, true, nil, nil, 3)
	elseif randint == 2 then
		CreateUnitByName(a2, abadloc, true, nil, nil, 3)
	elseif randint == 3 then
		CreateUnitByName(a3, abadloc, true, nil, nil, 3)
	end
	end
end
end



-- This function initializes the game mode and is called before anyone loads into the game
-- It can be used to pre-initialize any values/tables that will be needed later
function GameMode:InitGameMode()
  GameMode = self
  DebugPrint('[BAREBONES] Starting to load Barebones gamemode...')

  -- Commands can be registered for debugging purposes or as functions that can be called by the custom Scaleform UI
  Convars:RegisterCommand( "command_example", Dynamic_Wrap(GameMode, 'ExampleConsoleCommand'), "A console command example", FCVAR_CHEAT )

  DebugPrint('[BAREBONES] Done loading Barebones gamemode!\n\n')
end

-- This is an example console command
function GameMode:ExampleConsoleCommand()
  print( '******* Example Console Command ***************' )
  local cmdPlayer = Convars:GetCommandClient()
  if cmdPlayer then
    local playerID = cmdPlayer:GetPlayerID()
    if playerID ~= nil and playerID ~= -1 then
      -- Do something here for the player who called this command
      PlayerResource:ReplaceHeroWith(playerID, "npc_dota_hero_viper", 1000, 1000)
    end
  end

  print( '*********************************************' )
end