modifier_client_convars = class({})

function modifier_client_convars:OnCreated( params )
    if IsClient() then
        SendToConsole("dota_force_right_click_attack 0")
    end
end

function modifier_client_convars:IsHidden()
    return true
end

function modifier_client_convars:GetAttributes()
    return MODIFIER_ATTRIBUTE_PERMANENT
end