extends Node

@onready var player: CharacterBody2D = $PlayerCharacter
@onready var inventory_interface: Control = $"UI/InventoryInterface"
@onready var temp_inventory: Control = $UI/tempInventory
@onready var player_inventory: PanelContainer = $UI/tempInventory/PlayerInventory
@onready var pickableItem: Area2D = $UI/Items/Area2D

@onready var timer = Timer.new()
@onready var timer_active = false


func _ready() -> void:
	var load = load("res://Scenes/ui.tscn")
	var currentscene = load.instantiate()
	self.add_child(currentscene)
	player = $PlayerCharacter
	inventory_interface = $"UI/InventoryInterface"
	temp_inventory = $UI/tempInventory
	player_inventory = $UI/tempInventory/PlayerInventory
	pickableItem = $UI/Items/Area2D

	timer = Timer.new()
	timer_active = false
	inventory_interface.visible = false
	temp_inventory.visible = false
	add_child(timer)
	inventory_interface.setPlayerInventoryData(player.inventoryData)
	timer.timeout.connect(visibility_temp)
	

func _process(delta) -> void:
	if Input.is_action_just_pressed("OPEN_INVENTORY"):
		if inventory_interface.visible:
			inventory_interface.visible = false
			temp_inventory.setPlayerInventoryData(player.inventoryData)
			temp_inventory.visible = true
			
			if not timer_active:
				timer.start(1.5) 
				timer_active = true 
		else:
			inventory_interface.visible = true
			temp_inventory.visible = false
			timer.stop()
			timer_active = false
		

func visibility_temp() -> void:
	temp_inventory.visible = false
	timer_active = false
	

'''func _on_ready() -> void:
	var load = load("res://Scenes/ui.tscn")
	var currentscene = load.instantiate()
	self.add_child(currentscene)'''
