if CodeStudio.ServerType == "QB" then 
    QBCore = exports[CodeStudio.QBCoreGetCoreObject]:GetCoreObject()
elseif CodeStudio.ServerType == "ESX" then 
    ESX = exports[CodeStudio.ESXGetSharedObject]:getSharedObject()
end

local level = 0


RegisterNetEvent("cs:airsus:enterVeh", function(entityId)
    TriggerServerEvent('cs:airsus:fetch', NetworkGetNetworkIdFromEntity(entityId))
end)



RegisterNetEvent("cs:airsus:fetchChange", function(curVeh, value, lvl)
    level = lvl
    SetVehicleSuspensionHeight(NetToVeh(curVeh), value)
end)



RegisterCommand('air', function()
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "open",
        data = {
            lvl = level,
        }
    })
end)




RegisterNUICallback('cs:airsus:change', function(data, cb)
    local veh = GetVehiclePedIsIn(PlayerPedId())
    local vPlate = GetVehicleNumberPlateText(veh)
    if data.type == 'up' then 
        if level == CodeStudio.Maximum then 
            cb('Maximum')
            return 
        end
        SetVehicleSuspensionHeight(veh, GetVehicleSuspensionHeight(veh) - CodeStudio.ChangePerLevel)
        level = level + 1
    elseif data.type == 'down' then 
        if level == CodeStudio.Minimum then 
            cb('Minimum')
            return 
        end
        SetVehicleSuspensionHeight(veh, GetVehicleSuspensionHeight(veh) + CodeStudio.ChangePerLevel)
        level = level - 1
    end
    TriggerServerEvent('cs:airsus:update', NetworkGetNetworkIdFromEntity(veh), level, GetVehicleSuspensionHeight(veh))
    cb(level)
end)


RegisterNUICallback('cs:airsus:closeUI', function(data,cb)
    SetNuiFocus(false, false)
    cb(true)
end)



SetNetworkWalkMode(true)