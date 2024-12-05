extends CharacterBody2D
@export var inventoryData: InventoryData
@onready var pickItem: Area2D = $"../UI/Items/Area2D"

const SPEED = 300.0
signal sendDeletedItem(item:ItemData)

func _ready() -> void:
	inventoryData = preload("res://Inventory/test_inv.tres")
	connect("sendDeletedItem", Callable(pickItem, "showDroppedItem"))

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
	var count = 0
	var currSlot = SlotData.new()
	currSlot.quantity = 1
	currSlot.itemData = item
	for slot in inventoryData.slot_datas:
		if slot == null and count == 0:
			inventoryData.slot_datas.push_front(currSlot)
			count += 1
		else:
			print("slots full")
	inventoryData.inventoryUpdated.emit(inventoryData)
	
func dropItem() -> void:
	var remItem = inventoryData.slot_datas[0].itemData
	sendDeletedItem.emit(remItem)
	inventoryData.slot_datas.remove_at(0)
	for i in range(1,len(inventoryData.slot_datas)):
		if(i < len(inventoryData.slot_datas)-1):
			inventoryData.slot_datas[i-1] = inventoryData.slot_datas[i]
	inventoryData.inventoryUpdated.emit(inventoryData)
