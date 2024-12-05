extends Resource

class_name InventoryData

signal inventoryUpdated(inventoryData: InventoryData)
signal inventoryInteract(inventoryData: InventoryData, index: int, button: int)

@export var slot_datas: Array[SlotData]
#@onready var pickItem: Area2D = $"../UI/Items/Area2D"
#@onready var item_pickable: Area2D = $"."

func onSlotClicked(index: int, button: int) -> void:
	inventoryInteract.emit(self, index, button)
	#connect("sendDeletedItem", Callable(pickItem, "showDroppedItem"))

func grabSlotData(index: int) -> SlotData:
	var slotData = slot_datas[index]
	if slotData:
		slot_datas[index] = null
		inventoryUpdated.emit(self)
		return slotData
	else:
		return null

func dropSlotData(grabbedSlotData:SlotData, Index: int) -> SlotData:
	var slotData = slot_datas[Index]
	
	var returnSlotData: SlotData
	slot_datas[Index] = grabbedSlotData
	returnSlotData = slotData
	
	inventoryUpdated.emit(self)
	return returnSlotData
		
func dropSingleSlotData(grabbedSlotData: SlotData, Index: int) -> SlotData:
	var newSlotData = slot_datas[Index]
	if not newSlotData:
		slot_datas[Index] = grabbedSlotData.createSingleSlotData()
	inventoryUpdated.emit(self)
	
	if grabbedSlotData.quantity > 0:
		return grabbedSlotData
	return null



func appendItem(item:ItemData) -> void:
	print("method called")
	print(item.name)
	var count = 0
	var currSlot = SlotData.new()
	currSlot.quantity = 1
	currSlot.itemData = item
	for slot in slot_datas:
		if slot == null and count == 0:
			slot_datas.push_front(currSlot)
			count += 1
		else:
			print("slots full")
		inventoryUpdated.emit(self)
		



func dropItem() -> void:
	var remItem = slot_datas[0].itemData
	#sendDeletedItem.emit(remItem)
	slot_datas.remove_at(0)
	for i in range(1,len(slot_datas)):
		if(i < len(slot_datas)-1):
			slot_datas[i-1] = slot_datas[i]
	inventoryUpdated.emit(self)
	
