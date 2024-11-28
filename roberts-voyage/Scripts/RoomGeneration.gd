extends Node

var currentBiom = "U"

var Bioms = ["U", "S", "H"]

var currentLevelinBiom = 0

var characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
var loaded_scene = load("res://Scenes/Rooms/Room_UA0.tscn");
var currentscene = loaded_scene.instantiate();

var enemyamount = 0


func initrooms():
	get_tree().root.call_deferred("add_child", currentscene)

func increaselevel():
	currentLevelinBiom += 1;

func createnewroom():
	currentscene.queue_free();
	if(currentLevelinBiom == 3):
		var load = load("res://Scenes/Rooms/Room_"+ currentBiom + characters[randi_range(0,0)]+"1.tscn");
		currentscene = load.instantiate()
		get_tree().root.call_deferred("add_child", currentscene)
		Enemyspawning.spawn_enemy()
		enemyamount = enemyamount +1;
	else:
		var load = load("res://Scenes/Rooms/Room_"+ currentBiom + characters[randi_range(0,0)]+"0.tscn");
		currentscene = load.instantiate()
		get_tree().root.call_deferred("add_child", currentscene)
		Enemyspawning.spawn_enemy()
		enemyamount = enemyamount +1;
func createnewbossroom():
	pass
