extends Node

var currentBiom = "U"

var Bioms = ["U", "S", "H"]

var currentLevelinBiom = 0

var characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
var genstring  = "res://Scenes/Rooms/Room_UA0.tscn"
var loaded_scene = load(genstring);
var currentscene = loaded_scene.instantiate();


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
	else:
		var load = load("res://Scenes/Rooms/Room_"+ currentBiom + characters[randi_range(0,0)]+"0.tscn");
		currentscene = load.instantiate()
		get_tree().root.call_deferred("add_child", currentscene)
func createnewbossroom():
	pass
