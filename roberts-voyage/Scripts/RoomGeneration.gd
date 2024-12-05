extends Node

var currentBiom = "U"

var Bioms = ["U", "S", "H"]

var currentLevelinBiom = 0

var characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
var loaded_scene = load("res://Scenes/Rooms/Room_UA0.tscn");
var currentscene = loaded_scene.instantiate();

var enemyamount = 0
var gobj

func initrooms(gameobj):
	gobj = gameobj
	await get_tree().create_timer(1).timeout;
	loaded_scene = load("res://Scenes/Rooms/Room_UA0.tscn");
	currentscene = loaded_scene.instantiate();
	gobj.call_deferred("add_child", currentscene)

func increaselevel():
	currentLevelinBiom += 1;

func createnewroom():
	currentscene.queue_free();
	await get_tree().create_timer(1).timeout;
	if(currentLevelinBiom == 3):
		var load = load("res://Scenes/Rooms/Room_"+ currentBiom + characters[randi_range(0,0)]+"1.tscn");
		currentscene = load.instantiate()
		gobj.add_child(currentscene)
		Enemyspawning.spawn_enemy()
	else:
		var load = load("res://Scenes/Rooms/Room_"+ currentBiom + characters[randi_range(0,0)]+"0.tscn");
		currentscene = load.instantiate()
		#get_tree().root.call_deferred("add_child", currentscene)
		gobj.add_child(currentscene)
		Enemyspawning.spawn_enemy()
	


func createnewbossroom():
	pass
