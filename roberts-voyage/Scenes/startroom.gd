extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var inventory_interface = $UI/InventoryInterface
@onready var temp_inventory: Control = $UI/tempInventory
@onready var player_inventory: PanelContainer = $UI/tempInventory/PlayerInventory


var timer:SceneTreeTimer

func _ready() -> void:
	inventory_interface.visible = false
	temp_inventory.visible = false
	inventory_interface.setPlayerInventoryData(player.inventoryData)


func _process(delta) -> void:
	if Input.is_action_just_pressed("OPEN_INVENTORY"):
		if inventory_interface.visible == true:
			inventory_interface.visible = false
			temp_inventory.setPlayerInventoryData(player.inventoryData)
			setMouseFilterIgnore(temp_inventory)
			temp_inventory.visible = true
			timer = get_tree().create_timer(1.5)
			timer.timeout.connect(visibility_temp)
		elif inventory_interface.visible == false:
			inventory_interface.visible = true
		print(inventory_interface.visible)

func visibility_temp() -> void: 
	temp_inventory.visible = false
	
func setMouseFilterIgnore(inv: Control)-> void:
	inv.mouse_filter = Control.MOUSE_FILTER_IGNORE
	for child in player_inventory:
		for slot in child.item_grid:
			
			
