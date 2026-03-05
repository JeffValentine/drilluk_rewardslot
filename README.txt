DrillUK Reward Slot (FiveM Resource)

Install:
1) Drop `drilluk_rewardslot` into your server resources folder.
2) Add to server.cfg:
   ensure drilluk_rewardslot

Test:
- In game: /drillreward
- Or from another script:
  exports['drilluk_rewardslot']:OpenRewardSlot()

Notes:
- Replace server reward logic in server/server.lua -> giveReward()
- Emoji icons can be swapped for images by editing html/app.js + adding assets to html/
