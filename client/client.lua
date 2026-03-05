local isOpen = false

-- Open from other scripts:
-- exports['drilluk_rewardslot']:OpenRewardSlot()
exports('OpenRewardSlot', function()
  TriggerServerEvent('drilluk_rewardslot:server:requestSpin')
end)

RegisterCommand('drillreward', function()
  TriggerServerEvent('drilluk_rewardslot:server:requestSpin')
end, false)

RegisterNetEvent('drilluk_rewardslot:client:open', function(payload)
  if isOpen then return end
  isOpen = true

  SetNuiFocus(true, true)
  SendNUIMessage({
    action = 'open',
    payload = payload
  })
end)

RegisterNUICallback('close', function(_, cb)
  SetNuiFocus(false, false)
  isOpen = false
  cb({ ok = true })
end)

RegisterNUICallback('spinComplete', function(data, cb)
  -- data = { rewardId = 'cash_small', label='£5,000', rarity='rare', amount=5000 }
  TriggerServerEvent('drilluk_rewardslot:server:grantReward', data)
  cb({ ok = true })
end)

-- Small “dopamine” extras: subtle screenshake bursts while spinning/winning
RegisterNUICallback('haptic', function(data, cb)
  -- data.kind: "tick" | "win" | "bigwin"
  if data.kind == "tick" then
    ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 0.03)
  elseif data.kind == "win" then
    ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 0.08)
  elseif data.kind == "bigwin" then
    ShakeGameplayCam("LARGE_EXPLOSION_SHAKE", 0.18)
  end
  cb({ ok = true })
end)
