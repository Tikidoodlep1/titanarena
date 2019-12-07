function ManaBurn(keys)
local caster = keys.caster
local target = keys.target
local mana = target:GetMana()

target:SetMana(mana - 10)
end

function FrostAttack(keys)
local caster = keys.caster
local target = keys.target
local ability = keys.ability

target:ApplyDataDrivenModifier(caster, target, "ghost_frost_attack_modifier", {duration = 2})

end