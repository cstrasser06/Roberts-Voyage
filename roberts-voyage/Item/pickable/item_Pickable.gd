extends Area2D

@export var item_data:ItemData
@onready var item_sprite: Sprite2D = $Sprite2D
@onready var item_collision: CollisionShape2D = $CollisionShape2D
@onready var area_item: Area2D = $item_pickable
@onready var inventory_data: InventoryData


@onready var player: CharacterBody2D = $"../../../PlayerCharacter"

signal item_collected(item:ItemData)
signal getInventory(inventoryData:InventoryData)
var rng = RandomNumberGenerator.new()
signal dropItemSlot()
func _ready():
	item_data = ItemData.new()
	
	for i in range(1,5):
		initialiseItem()
	'''connect("item_collected", Callable(inventory_data, "appendItem"))
	connect("getInventory", Callable())
	connect("dropItemSlot",Callable(player.inventoryData,"dropItem"))
	if Input.is_action_just_released("DROPITEM"):
		dropItemSlot.emit(player.inventoryData)'''

func initialiseItem() -> void:
	var name = spawn_Rnd_Name()
	var path = "res://Item/items/%s.tres" %name
	item_data = load(path) as ItemData
	item_sprite.texture = item_data.texture
	item_sprite.position = Vector2(randf_range(0,1600),randf_range(0,800))
	item_collision.position = item_sprite.position
	item_data.coordinate = item_sprite.position

func spawn_Rnd_Name() -> String:
	var items = ["orange_pot", "book", "blue_pot"]
	var rnd = rng.randf_range(0,len(items))
	return items[rnd]

func _on_body_entered(body: Node2D) -> void:
	if body == player: 
		print(item_data.name)
		item_collected.emit(item_data)
		queue_free()
		
func showDroppedItem(item:ItemData):
	var drppedItem = item
	item_sprite.texture = drppedItem.texture
	item_sprite.position = player.position+Vector2(20,20)
	item_collision.position = item_sprite.position
	drppedItem.coordinate = item_sprite.position

func setItemData(itemD:ItemData):
	item_data = itemD
	item_sprite.texture = itemD.texture
	item_collision.position = itemD.coordinate
