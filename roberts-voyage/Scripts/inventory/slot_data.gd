extends Resource

class_name SlotData

const MAX_STACK_SIZE: int = 64

@export var itemData: ItemData
@export_range(1, MAX_STACK_SIZE) var quantity = 1: set = setQuantity


func canMergeWithSameItem(slotData: SlotData) -> bool:
	if slotData.itemData.name == itemData.name and slotData.itemData.stackable \
	 and slotData.quantity + quantity < MAX_STACK_SIZE:
		return true
	else:
		return false

	
func createSingleSlotData() -> SlotData:
	var newSlotData = duplicate()
	newSlotData.quantity = 1
	quantity -=1
	return newSlotData


func setQuantity(value: int):
	quantity = value
	if quantity > 1 and not itemData.stackable:
		quantity = 1
