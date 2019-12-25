function modifier_dablage(keys)
local target = keys.target
local caster = keys.caster
local estacks = target:GetModifierStackCount("modifier_stack_enemy", caster)
local stacks = caster:GetModifierStackCount("modifier_stack", caster)
local basedamage = caster:GetBaseDamageMax()
local ability = keys.ability
local stackdamage = ability:GetSpecialValueFor("damage_stack")
local appdamage = basedamage + (basedamage * ((stacks * stackdamage)/100))
local damage_table = {victim = target, attacker = caster, damage = appdamage, damage_type = DAMAGE_TYPE_PHYSICAL}
ability:ApplyDataDrivenModifier(caster, target, "modifier_stack_enemy", {})
target:SetModifierStackCount("modifier_stack_enemy", caster, estacks + 1)
ability:ApplyDataDrivenModifier(caster, caster, "modifier_stack", {})
caster:SetModifierStackCount("modifier_stack", caster, stacks + 1)
ApplyDamage(damage_table)
end