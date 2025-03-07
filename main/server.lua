local saveFile = "./saveData.json"
GlobalState.suspensionLevel = {}

AddEventHandler("onResourceStart", function(resource)
    if CodeStudio.SaveAfterRestart and resource == GetCurrentResourceName() then
        local loadFile = LoadResourceFile(GetCurrentResourceName(), saveFile)
        if not loadFile then
            SaveResourceFile(GetCurrentResourceName(), saveFile, json.encode({}), -1)
            return
        end
        Wait(1000)
        local storedData = json.decode(loadFile) or {}
        GlobalState.suspensionLevel = storedData
    end
end)

AddEventHandler('entityCreated', function(entity)
    Wait(500)
	if not CodeStudio.SaveAfterRestart then return end
    if not DoesEntityExist(entity) or GetEntityType(entity) ~= 2 then return end
    local plate = GetVehicleNumberPlateText(entity)
    if not plate or plate == "" then return end
    local loadFile = LoadResourceFile(GetCurrentResourceName(), saveFile)
    local openData = json.decode(loadFile) or {}

    if openData[plate] then
        GlobalState.suspensionLevel[plate] = openData[plate]
        TriggerClientEvent('cs:airsus:applySuspension', -1, NetworkGetNetworkIdFromEntity(entity), openData[plate].height)
    end
end)

RegisterNetEvent('cs:airsus:update', function(netID, level, height)
    local veh = NetworkGetEntityFromNetworkId(netID)
    if not DoesEntityExist(veh) then return end

    local plate = GetVehicleNumberPlateText(veh)
    if not plate or plate == "" then return end

    GlobalState.suspensionLevel[plate] = { level = level, height = height }
    TriggerClientEvent('cs:airsus:applySuspension', -1, netID, height)

	if not CodeStudio.SaveAfterRestart then return end
    local loadFile = LoadResourceFile(GetCurrentResourceName(), saveFile)
    local openData = json.decode(loadFile) or {}
    openData[plate] = { level = level, height = height }
    SaveResourceFile(GetCurrentResourceName(), saveFile, json.encode(openData, { indent = true }), -1)
end)

lib.addCommand('airsusp', { help = "Open the Air Suspension UI" }, function(source)
    TriggerClientEvent("cs:airsus:openUI", source)
end)