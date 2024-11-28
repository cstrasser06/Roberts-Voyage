extends Node2D

		
#func _ready():
#	await  get_tree().create_timer(1).timeout
#	spawn_enemy()
#	await  get_tree().create_timer(1).timeout
#	spawn_enemy()
#	await  get_tree().create_timer(1).timeout
#	spawn_enemy()

func spawn_enemy():
	var EnemyScene = load("res://Scenes/Enemie.tscn")
	var enemy = EnemyScene.instantiate()
	var randomx = randf_range(200, 1600)
	var randomy = randf_range(200, 800)
	enemy.position = Vector2(randomx, randomy)
	#add_child(enemy)
	get_tree().root.call_deferred("add_child", enemy)
	
	
