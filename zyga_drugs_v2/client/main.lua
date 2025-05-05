local playerjob = "unemployed"

local JobToken = 0

RegisterNetEvent("zyga_drugs_v2:sendCode", function(code)
    JobToken = code
end)

local function jobix(jobcheck)
    playerjob = jobcheck.name
end

RegisterNetEvent('esx:setJob', function(jobcheck)
    jobix(jobcheck)
end)

CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(100)
    end

    while ESX.GetPlayerData().job == nil do
        Wait(100)
    end
    jobix(ESX.GetPlayerData().job)
end)
function cwelcheck()
    for a, ut in pairs(Config.Blacklistedjobs) do
        if playerjob == ut then
            ESX.ShowNotification('Blacklisted job!')
            return false
        end
    end

    return true
end


function DrawText3D(coords, text, scale)
    local x, y, z = coords.x, coords.y, coords.z
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())

    local cwel = Config.Textoptions

    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(cwel.font)
        SetTextProportional(1)
        SetTextColour(cwel.red, cwel.green, cwel.blue, cwel.alpha)
        SetTextEntry("STRING")
        SetTextCentre(1)
        if cwel.outline then
        SetTextOutline()
        end
        AddTextComponentString(text)
        DrawText(_x, _y)
        local factor = (string.len(text)) / 370
    end
end


function DrugMarker(coords)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local distance = #(playerCoords - coords)
    local rot = vec3(270.0, 0.0, 0.0)  

    local mcwel = Config.Markeroptions

    if distance <= mcwel.scalex-2 then
        DrawMarker(mcwel.type, coords.x, coords.y, coords.z - 0.95, 0.0, 0.0, 0.0, rot.x, rot.y, rot.z, mcwel.scalex, mcwel.scaley, mcwel.scalez, mcwel.r, mcwel.g, mcwel.b, mcwel.a, false, true, 2, false, false, false, false) -- kolor po wejsciu
    else
        DrawMarker(mcwel.type, coords.x, coords.y, coords.z - 0.95, 0.0, 0.0, 0.0, rot.x, rot.y, rot.z, mcwel.scalex, mcwel.scaley, mcwel.scalez, 255, 255, 255, 100, false, true, 2, false, false, false, false)
    end
end

function collect(config)
    TriggerServerEvent("zyga_drugs_v2:getCode")
    ESX.TriggerServerCallback('zyga_drugs:canCollect', function(canCollect)
        if not canCollect then
            ESX.ShowNotification("Can't collect!")
            return
        end
    
        exports[Config.ProgbarResource]:Progress({
            name = "narko" .. math.random(0, 9999999),
            duration = config.duration,
            label = config.text,
            useWhileDead = false,
            canCancel = true,
            controlDisables = {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            },
            animation = {
                animDict = config.animdict,
                anim = config.anim,
                flags = 49,
            },
        }, function(wasCancelled)
            if not wasCancelled then
                ClearPedTasks(PlayerPedId())
                TriggerServerEvent('zyga_drugs:finishCollect', config.itemstoadd, JobToken)
            end
        end)
    end, config)    
    Citizen.Wait(config.duration)
end




if Config.Interaction == 'target' then
    local asdnwm = math.random(0, 999999)
    for a, b in pairs (Config.Drugs) do
    exports.ox_target:addBoxZone({
        name = "narko" .. asdnwm,
        coords = b.coords,
        size = b.size,
        options = {
            {
                icon = b.icon,
                label = b.targettext,
                onSelect = function()
                    if not cwelcheck() then return end
                    collect(b)

                end
            }
        }
    })
end
end

if Config.Interaction == '3dtext' then
    CreateThread(function()
        while true do
    local kordygracza = GetEntityCoords(PlayerPedId())
    for a, b in pairs (Config.Drugs) do
        local dist = #(kordygracza - b.coords)
        if dist < 5.0 then
            DrawText3D(b.coords, b.text2, 0.5)
        end
        if dist < 2.0 then
            if IsControlJustReleased(0, 38) then
                collect(b)
            end
        end
        Citizen.Wait(0)
    end
end
end)
end



if Config.Interaction == 'marker' then
    CreateThread(function()
        while true do
    local kordygracza = GetEntityCoords(PlayerPedId())
    for a, b in pairs (Config.Drugs) do
        local dist = #(kordygracza - b.coords)
        if dist < Config.Markeroptions.disttoappear then
            DrugMarker(b.coords)
        end
        if dist < 2.0 then
            ESX.ShowHelpNotification(b.markertext)
            if IsControlJustReleased(0, 38) then
                collect(b)
            end
        end
        Citizen.Wait(0)
    end
end
end)
end

CreateThread(function()
    for a, b in pairs (Config.Drugs) do
if b.blip then
    local blip = AddBlipForCoord(b.coords)
    SetBlipSprite(blip, b.blipsprite)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, b.blipscale)
    SetBlipColour(blip, b.blipcolor)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(b.bliptext)
    EndTextCommandSetBlipName(blip)
end
end
end)


local propy = {}

CreateThread(function()
    for a, b in pairs(Config.Drugs) do
        if b.prop and b.propmodel and b.propvec then
            local model = GetHashKey(b.propmodel)

            RequestModel(model)
            while not HasModelLoaded(model) do
                Wait(10)
            end

            local asd = CreateObject(
                model,
                b.propvec.x,
                b.propvec.y,
                b.propvec.z,
                false, false, false
            )

            SetEntityHeading(asd, b.propvec.w)
            FreezeEntityPosition(asd, true)

            table.insert(propy, asd)
        end
    end
end)

AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() then
        for k, v in ipairs(propy) do
            if DoesEntityExist(v) then
                DeleteEntity(v)
            end
        end
    end
end)
