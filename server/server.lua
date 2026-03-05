local Rewards = {
  -- id, label, weight, rarity, amount(optional), meta(optional)
  { id = "cash_small", label = "£5,000",   weight = 55, rarity = "common", amount = 5000 },
  { id = "cash_med",   label = "£15,000",  weight = 25, rarity = "uncommon", amount = 15000 },
  { id = "cash_big",   label = "£50,000",  weight = 12, rarity = "rare", amount = 50000 },
  { id = "car_token",  label = "Vehicle Token", weight = 6, rarity = "epic" },
  { id = "drill_crate",label = "DrillUK Crate", weight = 2, rarity = "legendary" },
}

local function pickWeighted()
  local total = 0
  for _, r in ipairs(Rewards) do total = total + r.weight end

  local roll = math.random() * total
  local acc = 0
  for _, r in ipairs(Rewards) do
    acc = acc + r.weight
    if roll <= acc then return r end
  end
  return Rewards[#Rewards]
end

-- Replace this with your actual reward logic
local function giveReward(src, reward)
  -- Example placeholders:
  print(("[DrillUK RewardSlot] Giving %s (%s) to %d"):format(reward.id, reward.label, src))

  -- QBCore example:
  -- local Player = QBCore.Functions.GetPlayer(src)
  -- Player.Functions.AddMoney("cash", reward.amount or 0)

  -- ESX example:
  -- local xPlayer = ESX.GetPlayerFromId(src)
  -- xPlayer.addMoney(reward.amount or 0)
end

RegisterNetEvent('drilluk_rewardslot:server:requestSpin', function()
  local src = source
  local reward = pickWeighted()

  -- Send UI enough data to animate + display result
  TriggerClientEvent('drilluk_rewardslot:client:open', src, {
    brand = "DRILL-UK",
    theme = {
      -- pulled from your art vibe (neon purple / dark)
      neon = "#b538ca",
      neon2 = "#77119a",
      ink = "#140818",
      fog = "#2f1338"
    },
    reward = reward,
    reelPool = {
      -- Icons are emoji by default; swap to images later if you want.
      { id="cash", label="Cash", icon="💷" },
      { id="crate", label="Crate", icon="📦" },
      { id="token", label="Token", icon="🎟️" },
      { id="car", label="Car", icon="🚗" },
      { id="chain", label="Chain", icon="⛓️" },
      { id="drill", label="Drill", icon="🛠️" },
      { id="crown", label="Crown", icon="👑" }
    }
  })
end)

RegisterNetEvent('drilluk_rewardslot:server:grantReward', function(data)
  local src = source
  if type(data) ~= "table" or not data.rewardId then return end

  -- Trust model: the server already chose reward; you can also store it per-player if you want.
  -- Minimal check: only allow IDs from the table.
  local chosen
  for _, r in ipairs(Rewards) do
    if r.id == data.rewardId then chosen = r break end
  end
  if not chosen then
    print(("[DrillUK RewardSlot] Invalid rewardId from %d: %s"):format(src, tostring(data.rewardId)))
    return
  end

  giveReward(src, chosen)
end)
