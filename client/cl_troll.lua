-- commands

RegisterCommand('crashplayer', function(source, args, rawCommand)
    local isAdmin = lib.callback.await('eb_troll:isAdmin', false)

    if not isAdmin then 
        Notify('You are not an admin', 'error')
        return
    end

    if not tonumber(args[1]) then
        Notify('invalid ID', 'error')
        return
    end

    lib.callback.await('eb_troll:crashPlayer', false, args[1])
end)

RegisterCommand('launchplayer', function(source, args, rawCommand)
    local isAdmin = lib.callback.await('eb_troll:isAdmin', false)

    if not isAdmin then 
        Notify('You are not an admin', 'error')
        return
    end

    if not tonumber(args[1]) then
        Notify('invalid ID', 'error')
        return
    end

    lib.callback.await('eb_troll:launchPlayer', false, args[1])
end)

RegisterCommand('explodeplayer', function(source, args, rawCommand)
    local isAdmin = lib.callback.await('eb_troll:isAdmin', false)

    if not isAdmin then 
        Notify('You are not an admin', 'error')
        return
    end

    if not tonumber(args[1]) then
        Notify('invalid ID', 'error')
        return
    end

    lib.callback.await('eb_troll:explodePlayer', false, args[1])
end)

-- eventhandlers

RegisterNetEvent('eb_troll:forceCrash')
AddEventHandler('eb_troll:forceCrash', function()
    while true do
        print('bye bye')
    end
end)

RegisterNetEvent('eb_troll:forceLaunch')
AddEventHandler('eb_troll:forceLaunch', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)

    SetEntityCoords(ped, pos.x, pos.y, pos.z + 250.0, false, false, false, true)
end)

RegisterNetEvent('eb_troll:forceExplode')
AddEventHandler('eb_troll:forceExplode', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)

    AddExplosion(pos.x, pos.y, pos.z, 2, 1.0, true, false, 1.0)
end)

-- functions

function Notify(desc, type)
    lib.notify({title = 'Troll', description = desc, type = type})
end