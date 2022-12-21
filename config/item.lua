-------IF YOU ARE NOT USING QB/ESX EDIT THIS ACCORINGLY-------

if CodeStudio.ServerType == "QB" then 
    QBCore = exports[CodeStudio.QBCoreGetCoreObject]:GetCoreObject()
elseif CodeStudio.ServerType == "ESX" then 
    ESX = exports[CodeStudio.ESXGetSharedObject]:getSharedObject()
end


if CodeStudio.useItem then 
	if CodeStudio.ServerType == 'QB' then 
		QBCore.Functions.CreateUseableItem(CodeStudio.ItemName, function(source, item)
			TriggerClientEvent("cs:airsus:openUI", source)
		end)
	elseif  CodeStudio.ServerType == 'ESX' then 
		ESX.RegisterUsableItem(CodeStudio.ItemName, function(source)
			TriggerClientEvent('cs:airsus:openUI', source)
		end)
	end
end
