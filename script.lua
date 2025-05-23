vanilla_model.PLAYER:setVisible(false)
vanilla_model.ARMOR:setVisible(false)
vanilla_model.CAPE:setVisible(false)

local bruhapi = require("bruhapi")

function events.entity_init()
  bruhapi.itemView:new(
    models.model.Base.Torso.RightArmAdditional.RightShoulderAdditional.RightAdditionalItemPivot,
    bruhapi.utils.hotbarSlot(7),
    bruhapi.itemView.config:mainHand():withHideVirtualOnSelectedMainHand()
  )
  bruhapi.itemView:new(
    models.model.Base.Torso.LeftArmAdditional.LeftShoulderAdditional.LeftAdditionalItemPivot,
    bruhapi.utils.hotbarSlot(8),
    bruhapi.itemView.config:offHand():withHideVirtualOnSelectedOffHand()
  )
  bruhapi.itemView:new(
    models.model.Base.SameScaleItemPivot,
    bruhapi.utils.inventorySlot(1, 9),
    bruhapi.itemView.config:sameScale()
  )
  -- bruhapi.utils.hotbarSlot(slot: 1..9)
  -- bruhapi.utils.armorSlot(slot: 1..4)
  -- bruhapi.utils.inventorySlot(row: 1..3, column: 1..9)
  -- bruhapi.utils.secondArmSlot()
end
