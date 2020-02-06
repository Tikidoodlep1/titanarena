modifier_patron = class({})

function modifier_patron:IsHidden() return true end
function modifier_patron:IsPurgable() return false end
function modifier_patron:IsPurgeException() return false end
function modifier_patron:RemoveOnDeath() return false end

function modifier_patron:GetEffectName()
	return "particles/econ/events/ti7/ti7_hero_effect.vpcf"
end