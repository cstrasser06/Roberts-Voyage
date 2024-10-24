extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var inventory_interface = $UI/InventoryInterface

func _ready() -> void:
	inventory_interface.visible = false
	inventory_interface.setPlayerInventoryData(player.inventoryData)


func _process(delta) -> void:
	if Input.is_action_just_pressed("OPEN_INVENTORY"):
		inventory_interface.visible = !inventory_interface.visible
