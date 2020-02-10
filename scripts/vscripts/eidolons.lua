function spawn_eidolons(keys)
local caster = keys.caster
local ability = keys.ability
local target = keys.target
local abil_level = keys.ability:GetLevel()
local eidolon_hp = ability:GetSpecialValueFor("eidolon_hp_tooltip")
local eidolon_damage = ability:GetSpecialValueFor("eidolon_dmg_tooltip")
local point = target:GetAbsOrigin()
local talent_dmg = caster:FindAbilityByName("special_bonus_unique_enigma_3")
local talent_dmg_lvl = talent_dmg:GetLevel()
local bonus_dmg = 0
local eidelons = 3
local talent_eidelons = caster:FindAbilityByName("special_bonus_unique_enigma")
local talent_eidelons_lvl = talent_eidelons:GetLevel()


if talent_damage_lvl == 1 then
bonus_dmg = 60
	end


if talent_eidelons_lvl == 1 then
eidelons = eidelons + 7
end


target:Kill(ability, caster)
ability.caster = caster
for i = 0, eidelons-1, 1 do
local unit = CreateUnitByName("npc_dota_eidolon", point, true, caster, caster, caster:GetTeamNumber())

unit:SetControllableByPlayer(caster:GetPlayerID(), false)


unit:SetMaxHealth(eidolon_hp)
unit:SetHealth(unit:GetMaxHealth())
unit:SetBaseDamageMax(eidolon_damage+bonus_dmg)
unit:SetBaseDamageMin(eidolon_damage+bonus_dmg)
-- Adds the green duration circle, and kills the eidelon after the duration ends
			unit:AddNewModifier(unit, nil, "modifier_kill", {duration = 35})
			-- Phases the eidelon for a short period so there is no unit collision
			unit:AddNewModifier(unit, nil, "modifier_phased", {duration = 0.03})
			-- Applies the modifier to count each eidelon's attacks
			ability:ApplyDataDrivenModifier( unit, unit, "modifier_check_attacks", {duration = 50} )
			-- Takes note of the game time, so we know the duration for the split eidelons
			unit.time = GameRules:GetGameTime()
end
end

function CheckAttacks(keys)
	local caster = keys.caster -- The eidelon
	local target = keys.target -- The target it is attacking
	local ability = keys.ability
	local attack_count = ability:GetLevelSpecialValueFor("split_attack_count", ability:GetLevel())
	local duration = ability:GetLevelSpecialValueFor("duration_tooltip", ability:GetLevel())
	local time_left = 35 - (GameRules:GetGameTime() - caster.time)
	
	-- Counts the number of attacks for each eidelon
	if target:GetTeam() ~= caster:GetTeam() and target:IsBuilding() == false then
		if caster.attacks == nil then
			caster.attacks = 1
		else
			caster.attacks = caster.attacks + 1
		end
	end
	
	-- If the number of attacks is greater than the necessary count, we split the eidelon (create a new one)
	if caster.attacks >= attack_count then
		local eidelon = CreateUnitByName(caster:GetUnitName(), caster:GetAbsOrigin(), true, ability.caster, ability.caster, ability.caster:GetTeam())
		eidelon:SetForwardVector(caster:GetForwardVector())
		eidelon:SetControllableByPlayer(ability.caster:GetPlayerID(), true)
		eidelon:SetOwner(ability.caster)
		eidelon:SetMaxHealth(caster:GetMaxHealth())
		eidelon:SetHealth(caster:GetMaxHealth())
		eidelon:SetBaseDamageMax(caster:GetBaseDamageMax())
		eidelon:SetBaseDamageMin(caster:GetBaseDamageMin())
		
		--Adds the green duration circle, and kill the eidelon after the duration ends
		eidelon:AddNewModifier(eidelon, nil, "modifier_kill", {duration = time_left})
		-- Phases the eidelon for a short period so there is no unit collision
		eidelon:AddNewModifier(eidelon, nil, "modifier_phased", {duration = 0.03})
		-- Remove the modifier to check attacks
		caster:RemoveModifierByName("modifier_check_attacks")
		-- Heal the original eidelon to full
		caster:Heal(caster:GetMaxHealth(), caster)
	end
end