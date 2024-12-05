extends Node2D

		
#func _ready():
#	await  get_tree().create_timer(1).timeout
#	spawn_enemy()
#	await  get_tree().create_timer(1).timeout
#	spawn_enemy()
#	await  get_tree().create_timer(1).timeout
#	spawn_enemy()
var EnergyBallEnemyScene = preload("res://Scenes/EnergyBallEnemie.tscn")

func spawn_energyball():
	
	var enemy = EnergyBallEnemyScene.instantiate()
	var randomx = randf_range(600, 1600)
	var randomy = randf_range(200, 800)
	enemy.position = Vector2(randomx, randomy)
	#add_child(enemy)
	get_tree().root.add_child(enemy)

func spawn_bossU():
	pass
	
func _process(delta: float) -> void:
	if Player.currentHP <=0:
		for i in get_tree().root.get_children():
			if i.name.contains("Enemie"):
				i.queue_free();
	
	
