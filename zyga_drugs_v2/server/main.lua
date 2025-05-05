local ESX = exports['es_extended']:getSharedObject()


local PlayerToken = {}

local function GenerateRandomToken(length)
    local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()-_=+[]{};:,.<>?/"
    local token = ""

    for i = 1, length do
        local rand = math.random(1, #chars)
        token = token .. chars:sub(rand, rand)
    end

    return token
end

local function GenerateAndSendToken(_source)
    local token = GenerateRandomToken(64) 
    PlayerToken[_source] = token
    TriggerClientEvent("zyga_drugs_v2:sendCode", _source, token)
end


RegisterNetEvent("zyga_drugs_v2:getCode", function()
    local _source = source
    GenerateAndSendToken(_source)
end)

ESX.RegisterServerCallback('zyga_drugs:canCollect', function(source, cb, config)
    local xCwel = ESX.GetPlayerFromId(source)

    if config.jobtocollect and #config.jobtocollect > 0 then
        local kurwajebanaja = false
        for key, walju in pairs(config.jobtocollect) do
            if xCwel.job.name == walju then
                kurwajebanaja = true
                break
            end
        end
        if not kurwajebanaja then
            cb(false)
            return
        end
    end

    if config.licensetocollect and #config.licensetocollect > 0 then
        local lickaisthere = false
        local sql = MySQL.query.await('SELECT type FROM user_licenses WHERE owner = ?', {xCwel.identifier})
        for kij, val in pairs(sql) do
            for szit, huj in pairs(config.licensetocollect) do
                if val.type == huj then
                    lickaisthere = true
                    break
                end
            end
        end

        if not lickaisthere then
            cb(false)
            return
        end
    end

    local mmmmmm = config.itemstoremove or {}
    for ajtem, wyjebkatypublik in pairs(mmmmmm) do
        local itemek = xCwel.getInventoryItem(ajtem)
        if wyjebkatypublik > 0 and (not itemek or itemek.count < wyjebkatypublik) then
            cb(false)
            return
        end
    end

    for ajtem, wyjebkatypublik in pairs(mmmmmm) do
        if wyjebkatypublik > 0 then
            xCwel.removeInventoryItem(ajtem, wyjebkatypublik)
        end
    end

    cb(true)
end)

RegisterNetEvent('zyga_drugs:finishCollect')
AddEventHandler('zyga_drugs:finishCollect', function(itemstoadd, code)
    local _source = source
    if code ~= PlayerToken[_source] then
        return
    end

    PlayerToken[_source] = nil

    GenerateAndSendToken(_source)
    local xCwel = ESX.GetPlayerFromId(source)
    for ajtem, amount in pairs(itemstoadd) do
        xCwel.addInventoryItem(ajtem, amount)
    end
end)
