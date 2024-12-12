extends Control

var grabbedSlotData: SlotData

@onready var player_inventory: PanelContainer = $PlayerInventory

@onready var grabbed_slot: PanelContainer = $grabbedSlot
@onready var player: CharacterBody2D = $"../../PlayerCharacter"
@onready var inventory_data:InventoryData = player_inventory.get_inventory_data()

func _physics_process(delta: float) -> void:
	if grabbed_slot.visible:
		grabbed_slot.global_position = get_global_mouse_position() + Vector2(0.5,0.5)
	if Input.is_action_just_pressed("DROPITEM") and grabbedSlotData:
		dropGrabbedItem()
		
func dropGrabbedItem() -> void:
	var drop_position = player.global_position + Vector2(32, 32)
	
	var dropped_item_data = grabbedSlotData.itemData
	
	var dropped_item_scene = preload("res://Item/pickable/item_pickable.tscn")
	var dropped_item = dropped_item_scene.instantiate()
	get_tree().get_root().add_child(dropped_item) 
	dropped_item.position = drop_position
	print(drop_position)
	print(player.position)
	print(dropped_item_data.name)
	#dropped_item.setItemData(dropped_item_data)
	
	removeGrabbedItemFromInventory()
	
func removeGrabbedItemFromInventory() -> void:
	var index = inventory_data.slot_datas.find(grabbedSlotData)
	
	if index >= 0:
		player_inventory.slot_datas[index] = null
		player_inventory.inventoryUpdated.emit(player_inventory) 
	
	grabbedSlotData = null
	updateGrabbedSlot()
	
func setPlayerInventoryData(invData: InventoryData) -> void:
	if invData == null:
		print("inventory is null")
	else:
		invData.inventoryInteract.connect(onInventoryInteract)
		player_inventory.setInventoryData(invData)

func onInventoryInteract(invData: InventoryData, index: int, button:int) -> void:
	match[grabbedSlotData, button]:
		[null, MOUSE_BUTTON_LEFT]:
			grabbedSlotData = invData.grabSlotData(index)
			if Input.is_action_just_pressed("DROPITEM"):
				invData.dropItem(grabbedSlotData, index)
		[null, MOUSE_BUTTON_RIGHT]:
			pass
		#[_, MOUSE_BUTTON_RIGHT]:
		#	grabbedSlotData = invData.dropItem(grabbedSlotData, index)
		[_, MOUSE_BUTTON_LEFT]:
			grabbedSlotData = invData.dropSlotData(grabbedSlotData, index)
	updateGrabbedSlot()

func updateGrabbedSlot() -> void:
	if grabbedSlotData:
		grabbed_slot.show()
		grabbed_slot.setSlotData(grabbedSlotData)
	else:
		grabbed_slot.hide()
