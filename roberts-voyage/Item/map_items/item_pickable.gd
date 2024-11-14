extends Area2D

@export var item_name = "generic_item" 
@export var item_texture  = "generic_texture"
@export var item:ItemData

signal item_collected(item)
var rng = RandomNumberGenerator.new()



func _ready():
	item = initialiseItem()
	$coll_item/pic_item.texture = "%s.tres" %item.name
	connect("body_entered", Callable(self, "onBodyEntered"))

func initialiseItem() -> ItemData:
	var item2:ItemData
	item2.name = spawn_Rnd_Name()
	item2.coord_x = spawn_Rnd_X()
	item2.coord_y = spawn_Rnd_Y()
	return item2

func _on_Area2D_body_entered(body):
	if body.name == "Player":  
		emit_signal("item_collected", item.name)  
		queue_free() 

func spawn_Rnd_X() -> int:
	var val = rng.randf_range(0,15)
	item.coord_x = val
	return val
func spawn_Rnd_Y() -> int:
	var val = rng.randf_range(0,8)
	item.coord_y = val
	return val

func spawn_Rnd_Name() -> String:
	var items = ["apple", "green book"]
	var rnd = rng.randf_range(0,1)
	return items[rnd]

func onBodyEntered(body):
	if body.name == "Player": 
		emit_signal("item_collected", item_name)  # Signal mit dem Itemnamen auslösen	
		queue_free()
