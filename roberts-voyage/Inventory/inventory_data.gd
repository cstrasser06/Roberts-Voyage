extends Resource
class_name InventoryData

@export var slot_datas: Array[SlotData]

func _ready():
	connectSlots()

func connectSlots():
	for slot in slot_datas:
		slot.pressed.connect(onSlotClicked)

func onSlotClicked():
	pass
