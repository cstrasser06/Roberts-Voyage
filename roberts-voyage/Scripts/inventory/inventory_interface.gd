extends Control

var grabbedSlotData: SlotData

@onready var player_inventory: PanelContainer = $PlayerInventory
@onready var grabbed_slot: PanelContainer = $grabbedSlot

func _physics_process(delta: float) -> void:
	if grabbed_slot.visible:
		grabbed_slot.global_position = get_global_mouse_position() + Vector2(0.5,0.5)
		

func setPlayerInventoryData(invData: InventoryData) -> void:
	if invData == null:
		print("inventory is null")
	else:
		invData.inventoryInteract.connect(onInventoryInteract)
		player_inventory.setInventoryData(invData)

	
func onInventoryInteract(invData: InventoryData, index: int, button:int) -> void:
	print("invData.grabSlotData(index).itemData.name")
	match[grabbedSlotData, button]:
		[null, MOUSE_BUTTON_LEFT]:
			grabbedSlotData = invData.grabSlotData(index)
		[null, MOUSE_BUTTON_RIGHT]:
			pass
		[_, MOUSE_BUTTON_RIGHT]:
			grabbedSlotData = invData.dropItem(grabbedSlotData, index)
		[_, MOUSE_BUTTON_LEFT]:
			grabbedSlotData = invData.dropSlotData(grabbedSlotData, index)
	updateGrabbedSlot()

func updateGrabbedSlot() -> void:
	if grabbedSlotData:
		grabbed_slot.show()
		grabbed_slot.setSlotData(grabbedSlotData)
	else:
		grabbed_slot.hide()
