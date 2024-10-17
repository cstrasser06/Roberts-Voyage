extends Area2D







func _on_body_entered(body: Node2D) -> void:
	print("Bye")
	body.queue_free();
	RoomGeneration.createnewroom();
	
