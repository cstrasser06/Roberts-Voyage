extends Node2D


@export var item_name = "generic_item" 
@export var item_texture  = "generic_texture"
@export var item:ItemData


signal item_collected(item)
var rng = RandomNumberGenerator.new()


func _ready():
	item = ItemData.new()
	item = initialiseItem()
	var path = "res://Item/items/%s.tres" % item_name
	print(path)
	$picture.texture = load(path)
	connect("body_entered", Callable(self, "onBodyEntered"))

func initialiseItem() -> ItemData:
	var item2 = ItemData.new()
	item2.name = spawn_Rnd_Name()
	print(item2.name)
	item2.coordinate = Vector2(randf_range(0,1600),randf_range(0,800))
	position = item2.coordinate
	return item2

func _on_Area2D_body_entered(body):
	if body.name == "Player":  
		emit_signal("item_collected", item.name)  
		queue_free() 

func spawn_Rnd_X() -> int:
	var val = float(rng.randf_range(0,1600))
	return val
func spawn_Rnd_Y() -> int:
	var val = float(rng.randf_range(0,900))
	return val

func spawn_Rnd_Name() -> String:
	var items = ["apple", "green book"]
	var rnd = rng.randf_range(0,1)
	return items[rnd]

func onBodyEntered(body):
	if body.name == "Player": 
		emit_signal("item_collected", item_name)  # Signal mit dem Itemnamen auslösen	
		queue_free()
