-- functions

local function notify(desc, type)
    lib.notify({title = 'Troll', description = desc, type = type})
end

local function checkGroup()
    local isAdmin = lib.callback.await('eb_troll:isAdmin', false)

    if not isAdmin then 
        notify('You are not an admin', 'error')
        return
    end
    return true
end

local function checkArgs(args)
    if not args or not tonumber(args) then
        notify('invalid ID', 'error')
        return
    end
    return true
end

-- commands

RegisterCommand('crashplayer', function(source, args, rawCommand)
    local adminFound = checkGroup()
    local argsFound = checkArgs(args[1])
    if not adminFound or not argsFound then return end

    lib.callback.await('eb_troll:crashPlayer', false, args[1])
end)

RegisterCommand('launchplayer', function(source, args, rawCommand)
    local adminFound = checkGroup()
    local argsFound = checkArgs(args[1])
    if not adminFound or not argsFound then return end

    lib.callback.await('eb_troll:launchPlayer', false, args[1])
end)

RegisterCommand('explodeplayer', function(source, args, rawCommand)
    local adminFound = checkGroup()
    local argsFound = checkArgs(args[1])
    if not adminFound or not argsFound then return end

    lib.callback.await('eb_troll:explodePlayer', false, args[1])
end)

-- eventhandlers

RegisterNetEvent('eb_troll:forceAction')
AddEventHandler('eb_troll:forceAction', function(action)
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)

    if action == 'crash' then
        while true do
            print('bye bye')
        end
    elseif action == 'launch' then
        SetEntityCoords(ped, pos.x, pos.y, pos.z + 100.0, false, false, false, true)
    elseif action == 'explode' then
        AddExplosion(pos.x, pos.y, pos.z, 2, 1.0, true, false, 1.0)
    end
end)
