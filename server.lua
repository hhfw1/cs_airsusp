local VehData = {}


AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		local loadFile = LoadResourceFile(GetCurrentResourceName(), "./saveData.json")  
		if not json.decode(loadFile) then
			SaveResourceFile(GetCurrentResourceName(), "saveData.json", json.encode({}), -1)
		end
	end
end)
 

RegisterNetEvent("baseevents:enteredVehicle", function(currentVehicle, currentSeat)
    local src = source
    if (currentSeat == -1) then
        TriggerClientEvent("cs:airsus:enterVeh", src, currentVehicle)
    end 
end)


RegisterServerEvent('cs:airsus:fetch', function(netID)
	local src = source
	local loadFile = LoadResourceFile(GetCurrentResourceName(), "./saveData.json")  
	local openData = json.decode(loadFile)
	local found = false
	plate = GetVehicleNumberPlateText(NetworkGetEntityFromNetworkId(netID))
	if CodeStudio.SaveAfterRestart then 
		if openData then
			for k, v in pairs(openData) do
				if v.plate == plate then
					found = true
					TriggerClientEvent('cs:airsus:fetchChange', -1, netID, v.value, v.level)
				end
			end
			if not found then
				TriggerClientEvent('cs:airsus:fetchChange', src, netID, 0, 0)
			end
		end
	else
		if VehData[plate] then 
			TriggerClientEvent('cs:airsus:fetchChange', -1, netID, VehData[plate].value, VehData[plate].level)
		else
			TriggerClientEvent('cs:airsus:fetchChange', src, netID, 0, 0)
		end
	end
end)



RegisterServerEvent('cs:airsus:update', function(netID, level, value)
	local loadFile = LoadResourceFile(GetCurrentResourceName(), "./saveData.json")  
	local openData = json.decode(loadFile)
	local newopenData = {}
	local found = false
	plate = GetVehicleNumberPlateText(NetworkGetEntityFromNetworkId(netID))
	if CodeStudio.SaveAfterRestart then 
		if openData then
			for k, v in pairs(openData) do
				if v.plate == plate then
					found = true
					v.value = value
					v.level = level
				end
				newopenData[#newopenData+1] = v
			end
			if not found then 
				local newValue = {plate = plate, value = value, level = level}
				newopenData[#newopenData+1] = newValue
			end
			SaveResourceFile(GetCurrentResourceName(), "saveData.json", json.encode(newopenData), -1)
		end
		TriggerClientEvent('cs:airsus:fetchChange', -1, netID, value, level)
	else
		if VehData[plate] then 
			VehData[plate].value = value
			VehData[plate].level = level
		else
			local newValue = {plate = plate, value = value, level = level}
			VehData[plate] = newValue
		end
		TriggerClientEvent('cs:airsus:fetchChange', -1, netID, value, level)
	end
end)



