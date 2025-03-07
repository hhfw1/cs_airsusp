local suspensionData = GlobalState.suspensionLevel or {}

AddStateBagChangeHandler('suspensionLevel', 'global', function(_, _, value)
    suspensionData = value or {}
end)

RegisterNetEvent('cs:airsus:applySuspension', function(netId, height)
    local veh = NetToVeh(netId)
    if DoesEntityExist(veh) then
        SetVehicleSuspensionHeight(veh, height)
    end
end)

lib.onCache('vehicle', function(veh, oldVeh)
    if veh and GetPedInVehicleSeat(veh, -1) == cache.ped then
        local plate = GetVehicleNumberPlateText(veh)
        if plate and plate ~= "" then
            local storedHeight = suspensionData[plate] and suspensionData[plate].height or 0
            SetVehicleSuspensionHeight(veh, storedHeight)
        end
    end
end)

function OpenSuspensionUI()
    local veh = cache.vehicle
    if not veh then
        print(CodeStudio.Language.not_veh)
        return
    end
    if cache.seat ~= -1 then
        print(CodeStudio.Language.only_driver)
        return
    end

    local plate = GetVehicleNumberPlateText(veh)
    local storedLevel = suspensionData[plate] and suspensionData[plate].level or 0

    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "openUI",
        level = storedLevel
    })
end

RegisterNUICallback('change', function(data, cb)
    local veh = cache.vehicle
    if not veh then
        print(CodeStudio.Language.not_veh)
        return
    end

    local plate = GetVehicleNumberPlateText(veh)
    if not plate or plate == "" then return end

    local level = suspensionData[plate] and suspensionData[plate].level or 0
    local height = suspensionData[plate] and suspensionData[plate].height or GetVehicleSuspensionHeight(veh)

    if data.type == 'up' and level < CodeStudio.Maximum then
        height = height - CodeStudio.ChangePerLevel
        level = level + 1
    elseif data.type == 'down' and level > CodeStudio.Minimum then
        height = height + CodeStudio.ChangePerLevel
        level = level - 1
    end

    suspensionData[plate] = { level = level, height = height }
    GlobalState.suspensionLevel = suspensionData

    TriggerServerEvent('cs:airsus:update', NetworkGetNetworkIdFromEntity(veh), level, height)

    cb(level)
end)

RegisterNUICallback('closeUI', function(_, cb)
    SetNuiFocus(false, false)
    cb(true)
end)

RegisterNetEvent("cs:airsus:openUI", function()
    OpenSuspensionUI()
end)