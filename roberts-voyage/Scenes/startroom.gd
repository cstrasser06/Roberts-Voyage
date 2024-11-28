extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var inventory_interface = $UI/InventoryInterface
@onready var temp_inventory: Control = $UI/tempInventory
@onready var player_inventory: PanelContainer = $UI/tempInventory/PlayerInventory
@onready var pickable_item: Node2D = $Items/item_Pickable

@onready var timer = Timer.new()
@onready var timer_active = false

func _ready():
	inventory_interface.visible = false
	temp_inventory.visible = false
	add_child(timer)
	add_child(pickable_item)
	inventory_interface.setPlayerInventoryData(player.inventoryData)
	timer.timeout.connect(visibility_temp)
	for item in get_tree().get_nodes_in_group("Items"): 
		item.connect("item_collected", Callable(self, "onItemCollected"))
	
	

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
		print(inventory_interface.visible)

func visibility_temp() -> void:
	temp_inventory.visible = false
	timer_active = false
	

func onItemCollected(item_name):
	match item_name:
		"apple":
			print("apple collected")
		"green book":
			print("book collected")
