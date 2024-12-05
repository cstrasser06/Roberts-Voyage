extends Area2D

var enimies = true;

func _process(delta: float) -> void:
	if RoomGeneration.enemyamount == 0:
		enimies = false
	
	if RoomGeneration.enemyamount == 0:
		$AnimatedSprite2D.play("exit")
		$CollisionShape2D.disabled = false
	elif RoomGeneration.enemyamount != 0:
		$AnimatedSprite2D.play("entry")
		$CollisionShape2D.disabled = true
		enimies = true


func _on_body_entered(body: Node2D) -> void:
	if !enimies:
		print("Bye")
		body.queue_free();
		RoomGeneration.increaselevel();
		RoomGeneration.createnewroom();
	
