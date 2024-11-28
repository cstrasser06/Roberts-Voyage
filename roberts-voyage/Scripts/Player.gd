extends Node

var currentHP = 3
var maxHP = 3

var currentEnergy = 3
var maxEnergy = 3

var Items = {}

var Ability = ""


func _process(delta: float) -> void:
	if currentHP <= 0:
		get_tree().change_scene_to_file("res://Scenes/Main_Menu.tscn");
