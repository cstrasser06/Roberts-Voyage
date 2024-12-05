extends Area2D

@export var item_data:ItemData
@onready var item_sprite: Sprite2D = $Sprite2D
@onready var item_collision: CollisionShape2D = $CollisionShape2D
@onready var area_item: Area2D = $item_pickable
@onready var player: CharacterBody2D = $"../../../Player"

signal item_collected(item)
var rng = RandomNumberGenerator.new()

func _ready():
	item_data = ItemData.new()
	for i in range(1,5):
		initialiseItem()
	connect("item_collected", Callable(player, "appendItem"))

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
	if body.name == "Player": 
		item_collected.emit(item_data)
		queue_free()
		
func showDroppedItem(item:ItemData):
	var drppedItem = item
	item_sprite.texture = drppedItem.texture
	item_sprite.position = player.position+Vector2(20,20)
	item_collision.position = item_sprite.position
	drppedItem.coordinate = item_sprite.position
	
