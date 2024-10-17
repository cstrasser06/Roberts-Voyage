extends PanelContainer

const Slot = preload("res://Inventory/slot.tscn")

@onready var item_grid: GridContainer = $MarginContainer/ItemGrid
@onready var color_rect = $"../../ColorRect"

func _ready() -> void:
		var inv_data = preload("res://test_inv.tres")
		populate_item_grid(inv_data.slot_datas)
		color_rect.visible = false
		visible = false

func _input(event):
	if(event.is_action_pressed("OPEN_INVENTORY")):
		visible = !visible
		color_rect.visible = !color_rect.visible

func set_inventory_data(inventory_data: InventoryData) -> void:
	populate_item_grid(inventory_data.slot_datas)
	
func populate_item_grid(slot_datas: Array[SlotData]) -> void:
	for child in item_grid.get_children():
		child.queue_free()

	for slot_data in slot_datas:
		var slot = Slot.instantiate()
		item_grid.add_child(slot)
	
		if slot_data:
			slot.set_slot_data(slot_data)
