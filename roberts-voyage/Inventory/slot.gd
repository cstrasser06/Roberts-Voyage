extends PanelContainer

signal slotClicked(index: int, button: int)

@onready var texture_rect: TextureRect = $MarginContainer/TextureRect
@onready var quantity_label: Label = $QuantityLabel

func setSlotData(data: SlotData) -> void:
	texture_rect.texture = data.itemData.texture
	tooltip_text = "%s\n%s" % [data.itemData.name, data.itemData.description]
	
	if data.itemData.stackable == false:
		data.quantity = 1;
		push_error("%s not stackable" %data.itemData.name)
		
	if data.quantity > 1:
		quantity_label.text = "x%s" % data.quantity
		quantity_label.show()
	else:
		quantity_label.hide()

#funktion von node aus der seite rauskopiert
func _on_texture_rect_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton \
	and (event.button_index == MOUSE_BUTTON_LEFT\
	or event.button_index == MOUSE_BUTTON_RIGHT) and event.is_pressed():
		slotClicked.emit(get_index(), event.button_index)
