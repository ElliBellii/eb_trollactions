-- functions

local function notify(id, desc, type)
    TriggerClientEvent('ox_lib:notify', id, {title = 'Troll', description = desc, type = type})
end

local function checkTarget(target)
    local xTarget = ESX.GetPlayerFromId(target)

    if not xTarget then
        notify(source, 'ID ' .. target .. ' is not online', 'error')
        return
    end
    return xTarget
end

local function logAction(message)
    if Config.enableLogs then
        local embeds = {
            {
                ["title"] = 'Troll Logs',
                ["description"] = message,
                ["color"] = Config.color,
                ["footer"] = {
                    ["text"] = os.date("%d/%m/%Y %H:%M:%S"),
                },
            }
        }
        PerformHttpRequest(Config.webhook, function(err, text, headers) end, 'POST', json.encode({ username = name, embeds = embeds }), { ['Content-Type'] = 'application/json' })
    end
end

-- callbacks

lib.callback.register('eb_troll:isAdmin', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local group = xPlayer.getGroup()

    for _, v in pairs(Config.allowedGroups) do
        if group == v then
            return true
        end
    end
    return
end)

lib.callback.register('eb_troll:crashPlayer', function(source, target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = checkTarget(target)
    if not xTarget then return end

    local message =
    '**An admin crashed a player**\n\n' ..
    '**Admin ID:** ' .. source .. '\n' ..
    '**Admin Identifier:** ' .. xPlayer.getIdentifier() .. '\n\n' ..
    '**Player ID:** ' .. target .. '\n' ..
    '**Player Identifier:** ' .. xTarget.getIdentifier() 
    logAction(message)

    TriggerClientEvent('eb_troll:forceAction', target, 'crash')
    notify(source, 'Crashed ID ' .. target, 'success')
end)

lib.callback.register('eb_troll:launchPlayer', function(source, target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = checkTarget(target)
    if not xTarget then return end

    local message =
    '**An admin launched a player**\n\n' ..
    '**Admin ID:** ' .. source .. '\n' ..
    '**Admin Identifier:** ' .. xPlayer.getIdentifier() .. '\n\n' ..
    '**Player ID:** ' .. target .. '\n' ..
    '**Player Identifier:** ' .. xTarget.getIdentifier() 
    logAction(message)

    TriggerClientEvent('eb_troll:forceAction', target, 'launch')
    notify(source, 'Launched ID ' .. target, 'success')
end)

lib.callback.register('eb_troll:explodePlayer', function(source, target)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = checkTarget(target)
    if not xTarget then return end

    local message =
    '**An admin exploded a player**\n\n' ..
    '**Admin ID:** ' .. source .. '\n' ..
    '**Admin Identifier:** ' .. xPlayer.getIdentifier() .. '\n\n' ..
    '**Player ID:** ' .. target .. '\n' ..
    '**Player Identifier:** ' .. xTarget.getIdentifier() 
    logAction(message)

    TriggerClientEvent('eb_troll:forceAction', target, 'explode')
    notify(source, 'Exploded ID ' .. target, 'success')
end)
