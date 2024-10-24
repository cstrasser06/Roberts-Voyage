extends PanelContainer

const Slot = preload("res://Inventory/slot.tscn")

@onready var item_grid: GridContainer = $MarginContainer/ItemGrid
@onready var quantity_label: Label = $QuantityLabel

func _ready() -> void:
	var inventoryData = preload("res://Inventory/test_inv.tres")
	fillGrid(inventoryData)

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
