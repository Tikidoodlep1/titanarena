if modifier_titan_slain == nil then
	modifier_titan_slain = class({})
end

function modifier_titan_slain:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_TOOLTIP,
    }
    return funcs
end

function modifier_titan_slain:IsHidden()
	return false
end

function modifier_titan_slain:IsBuff()
	return true
end

function modifier_titan_slain:Duration()
	return 600
end

function modifier_titan_slain:TextureName()
	return "resource/flash3/images/spellicons/titan_slain_buff"
end

function modifier_titan_slain:OnTooltip(keys)
	return "Gaining Bonus Gold Per Minute, Along With Increased Invader Strength!"
end