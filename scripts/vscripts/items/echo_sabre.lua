require('libraries/animations')


function bonus_attacks(keys)	
local ability = keys.ability
local caster = keys.caster
local enemy_target = keys.target
local abil_cooldown = ability:GetSpecialValueFor("AbilityCooldown")
print("checking echo sabre 2")
if ability:GetCooldownTimeRemaining() == 0 then
	ability:StartCooldown(5)
	local attacks_sent = 0
print("echo sabre 2 is off cooldown")

	Timers:CreateTimer(.3, function()
	if attacks_sent <= 1 then
		 StartAnimation(caster, {duration=1.5, activity=ACT_DOTA_ATTACK, rate=12.5, translate="sven_warcry", translate2="sven_shield"})
	caster:PerformAttack(enemy_target, true, true, true, false, true, false, false)
	print("extra attack sent!")
	attacks_sent = attacks_sent + 1	
		return .3
	end
		
	end)



end
end
