require('libraries/animations')


function bonus_attacks(keys)	
local ability = keys.ability
local caster = keys.caster
local enemy_target = keys.target
local abil_cooldown = ability:GetSpecialValueFor("AbilityCooldown")

if ability:GetCooldownTimeRemaining() == 0 then
	ability:StartCooldown(5)
	local attacks_sent = 0


	Timers:CreateTimer(.3, function()
	if attacks_sent <= 1 then
		ability:ApplyDataDrivenModifier(caster, enemy_target, "modifier_echo_sabre_2_debuff", {duration = .8})
		 StartAnimation(caster, {duration=1.5, activity=ACT_DOTA_ATTACK, rate=12.5, translate="sven_warcry", translate2="sven_shield"})
	caster:PerformAttack(enemy_target, true, false, true, false, true, false, false)

	attacks_sent = attacks_sent + 1	
		return .3
	end
		
	end)



end
end
