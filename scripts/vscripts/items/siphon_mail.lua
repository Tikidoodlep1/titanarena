require('libraries/playertables')
function apply_siphon_damage_modifier( keys )
local caster = keys.caster
local caster_team = caster:GetTeamNumber()
local ability = keys.ability
local loc = caster:GetAbsOrigin()
local distance = ability:GetSpecialValueFor("range")
local abil_duration = ability:GetSpecialValueFor("duration")
local ally_units = FindUnitsInRadius(caster_team, loc, nil, distance,DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
for num,unit in pairs(ally_units) do
ability:ApplyDataDrivenModifier(caster, unit, "damage_soak", {duration = abil_duration})
if unit == caster then
	local caster_particle = ParticleManager:CreateParticle("particles/blademail_syphon_all.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit)
	EmitSoundOn("DOTA_Item.BladeMail.Activate",caster)
	Timers:CreateTimer(abil_duration, function()
		ParticleManager:DestroyParticle(caster_particle, true)
		end)
ability:ApplyDataDrivenModifier(caster, caster, "damage_receiver", {duration = abil_duration})
end
local ally_particle = ParticleManager:CreateParticle("particles/siphon_allys.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit)
	Timers:CreateTimer(abil_duration, function()
		ParticleManager:DestroyParticle(ally_particle, true)
		end)
end

end

function send_damage(keys)
local damage_taker = keys.caster
local damage_dealer = keys.attacker
local heroes = HeroList:GetAllHeroes()
PrintTable(keys)
for num, hero in pairs(heroes) do
if hero:HasModifier("damage_receiver") and hero:GetTeamNumber() == damage_taker:GetTeamNumber() then
	hero:RemoveModifierByName("damage_soak")
local damageTable = {
	victim = hero,
	attacker = damage_dealer,
	damage = (damage_dealer:GetAverageTrueAttackDamage(damage_taker) * .25),
	damage_type = DAMAGE_TYPE_PURE,
}

ApplyDamage(damageTable)
ParticleManager:CreateParticle("particles/vacuum_syphon_mail.vpcf", PATTACH_ABSORIGIN_FOLLOW, hero)
SendOverheadEventMessage(nil, nil, OVERHEAD_ALERT_DAMAGE, hero, damage, damage_dealer)
end
end

end