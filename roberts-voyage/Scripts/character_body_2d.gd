extends CharacterBody2D
@export var inventoryData: InventoryData

const SPEED = 300.0

func _ready() -> void:
	inventoryData = preload("res://Inventory/test_inv.tres")

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionx := Input.get_axis("MOVELEFT", "MOVERIGHT")
	var directiony := Input.get_axis("MOVEUP", "MOVEDOWN")
	if directionx || directiony:
		velocity.x = directionx * SPEED
		velocity.y = directiony * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()

func appendItem(item:ItemData) -> void:
	print("method called")
	print(item.name)
	var currSlot = SlotData.new()
	currSlot.quantity = 1
	currSlot.itemData = item
	var count = 0
	for slot in inventoryData.slot_datas:
		if slot != null:
			print("called slot")
			if slot.canMergeWithSameItem(currSlot) and count == 0:
				print("mergedSlot")
				slot.mergeWithSameItem(currSlot)
				count+=1
	for slot in inventoryData.slot_datas:
		if slot == null and count == 0:
			print("adding new book")
			slot = SlotData.new()
			slot.itemData = item
			slot.quantity = 1
			count+=1
	inventoryData.inventoryUpdated.emit(inventoryData)
