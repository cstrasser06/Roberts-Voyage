extends Node2D


func _ready() -> void:
	RoomGeneration.initrooms(self)
func _process(delta: float) -> void:
	#print(Player.currentHP)
	if Player.currentHP <= 0:
		get_tree().change_scene_to_file("res://Scenes/Main_Menu.tscn")
		##Delete Enimies and Room
		
