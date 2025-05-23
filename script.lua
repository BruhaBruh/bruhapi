vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)
vanilla_model.CAPE:setVisible(false)

local bruhapi = require("bruhapi")

function events.entity_init()
  bruhapi.itemView:new(
    models.model.Base.Torso.RightArmAdditional.RightShoulderAdditional.RightAdditionalItemPivot,
    bruhapi.utils.hotbarSlot(1),
    bruhapi.itemView.config:default()
    :withHideOnSelectedMainHand()
    :withHideOnSelectedOffHand()
  )
  -- bruhapi.utils.hotbarSlot(slot: 1..9)
  -- bruhapi.utils.armorSlot(slot: 1..4)
  -- bruhapi.utils.inventorySlot(row: 1..3, column: 1..9)
  -- bruhapi.utils.secondArmSlot()
end
