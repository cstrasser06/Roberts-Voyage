extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Player.currentHP == 0:
		$Label.text = "Try Again"
		Player.currentHP = 3
		Player.maxHP = 3

		Player.currentEnergy = 3
		Player.maxEnergy = 3

		Player.Items = {}

		Player.Ability = ""


func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Game.tscn");
	
	

func _on_button_2_pressed() -> void:
	get_tree().quit(0);
