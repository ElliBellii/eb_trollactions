-- callbacks

lib.callback.register('eb_troll:isAdmin', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local group = xPlayer.getGroup()
    local isAdmin = false

    for _, v in pairs(Config.AllowedGroups) do
        if group == v then
            isAdmin = true
            break
        end
    end

    if isAdmin then
        return true
    end
    return false
end)

lib.callback.register('eb_troll:crashPlayer', function(source, target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)

    if not xTarget  then
        Notify(source, 'ID ' .. target .. ' is not online', 'error')
        return false
    end

    if Logs.EnableLogs then
        local message =
        '**An admin crashed a player**\n\n' ..
        '**Admin ID:** ' .. source .. '\n' ..
        '**Admin Identifier:** ' .. xPlayer.getIdentifier() .. '\n\n' ..
        '**Player ID:** ' .. target .. '\n' ..
        '**Player Identifier:** ' .. xTarget.getIdentifier() 
        LogAction(message)
    end

    TriggerClientEvent('eb_troll:forceCrash', target)
    Notify(source, 'Crashed ID ' .. target, 'success')
    return true
end)

lib.callback.register('eb_troll:launchPlayer', function(source, target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)

    if not xTarget  then
        Notify(source, 'ID ' .. target .. ' is not online', 'error')
        return false
    end

    if Logs.EnableLogs then
        local message =
        '**An admin launched a player**\n\n' ..
        '**Admin ID:** ' .. source .. '\n' ..
        '**Admin Identifier:** ' .. xPlayer.getIdentifier() .. '\n\n' ..
        '**Player ID:** ' .. target .. '\n' ..
        '**Player Identifier:** ' .. xTarget.getIdentifier() 
        LogAction(message)
    end

    TriggerClientEvent('eb_troll:forceLaunch', target)
    Notify(source, 'Launched ID ' .. target, 'success')
    return true
end)

lib.callback.register('eb_troll:explodePlayer', function(source, target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)
    
    if not xTarget  then
        Notify(source, 'ID ' .. target .. ' is not online', 'error')
        return false
    end

    if Logs.EnableLogs then
        local message =
        '**An admin exploded a player**\n\n' ..
        '**Admin ID:** ' .. source .. '\n' ..
        '**Admin Identifier:** ' .. xPlayer.getIdentifier() .. '\n\n' ..
        '**Player ID:** ' .. target .. '\n' ..
        '**Player Identifier:** ' .. xTarget.getIdentifier() 
        LogAction(message)
    end

    TriggerClientEvent('eb_troll:forceExplode', target)
    Notify(source, 'Exploded ID ' .. target, 'success')
    return true
end)

-- functions

function LogAction(message)
    local embeds = {
        {
            ["title"] = 'Troll Logs',
            ["description"] = message,
            ["color"] = Logs.Color,
            ["footer"] = {
                ["text"] = os.date("%d/%m/%Y %H:%M:%S"),
            },
        }
    }
    PerformHttpRequest(Logs.Webhook, function(err, text, headers) end, 'POST', json.encode({ username = name, embeds = embeds }), { ['Content-Type'] = 'application/json' })
end

function Notify(id, desc, type)
    TriggerClientEvent('ox_lib:notify', id, {title = 'Troll', description = desc, type = type})
end