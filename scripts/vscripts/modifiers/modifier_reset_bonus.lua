if modifier_reset_bonus == nil then
	modifier_reset_bonus = class({})
end

function modifier_reset_bonus:IsHidden()
    return false
end

function modifier_reset_bonus:IsPurgable()
    return false
end

function modifier_reset_bonus:Attributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_reset_bonus:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	}

	return funcs
end

function modifier_reset_bonus:	GetModifierBonusStats_Strength(params)
	return 20
end

function modifier_reset_bonus:GetModifierBonusStats_Agility(params)
	return 20
end

function modifier_reset_bonus:GetModifierBonusStats_Intellect(params)
	return 20
end