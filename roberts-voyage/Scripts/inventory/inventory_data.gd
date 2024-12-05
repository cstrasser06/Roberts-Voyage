extends Resource

class_name InventoryData

signal inventoryUpdated(inventoryData: InventoryData)
signal inventoryInteract(inventoryData: InventoryData, index: int, button: int)

@export var slot_datas: Array[SlotData]
signal dropItemGrid(remItem:SlotData)

func onSlotClicked(index: int, button: int) -> void:
	inventoryInteract.emit(self, index, button)
	#connect("dropItemGrid", Callable(pickItem, "dropItemGrid"))

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
