function Kill(keys)
local target = keys.target
local caster = keys.caster
local ability = keys.ability
local targethp = target:GetMaxHealth()
local maxtargethp = target:GetHealth()
if maxtargethp/targethp <= 0.20 then
	target:Kill(ability, caster)
end
end