extends Area2D







func _on_body_entered(body: Node2D) -> void:
	print("Bye")
	body.queue_free();
	get_tree().change_scene_to_file("res://Scenes/Main_Menu.tscn");
	
