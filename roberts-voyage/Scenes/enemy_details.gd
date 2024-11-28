extends CharacterBody2D

var health = 3;

func _process(delta: float) -> void:
	if health <= 0:
		get_parent().queue_free()
