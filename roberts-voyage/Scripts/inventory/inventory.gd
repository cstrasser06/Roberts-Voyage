extends PanelContainer

const Slot = preload("res://Inventory/slot.tscn")

@onready var item_grid: GridContainer = $MarginContainer/ItemGrid
@onready var quantity_label: Label = $QuantityLabel
@onready var inventoryData = preload("res://Inventory/test_inv.tres")
func _ready() -> void:
	setInventoryData(inventoryData)
	fillGrid(inventoryData)
	
func get_inventory_data() -> InventoryData:
	return inventoryData
func getItemGrid() -> GridContainer:
	return item_grid

func setInventoryData(invData:InventoryData) -> void:
	invData.inventoryUpdated.connect(fillGrid)
	fillGrid(invData)

func fillGrid(invData:InventoryData)-> void:
	#alle children löschen
	for child in item_grid.get_children():
		child.queue_free()
		
	#slot-daten in item-grid hinzufügen
	for data in invData.slot_datas:
		var slot = Slot.instantiate()
		item_grid.add_child(slot)
		
		slot.slotClicked.connect(invData.onSlotClicked)
		
		if data != null:
			slot.setSlotData(data)
