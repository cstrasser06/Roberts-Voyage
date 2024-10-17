extends Node

var currentBiom = "U"

var Bioms = ["U", "S", "H"]

var currentLevelinBiom = 0




func createnewroom():
	var characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
	if(currentLevelinBiom == 3):
		get_tree().change_scene_to_file("res://Scenes/Rooms/Room_"+ currentBiom + characters[randi_range(0,0)]+"1.tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/Rooms/Room_"+ currentBiom + characters[randi_range(0,0)]+"0.tscn")
	
func createnewbossroom():
	pass
