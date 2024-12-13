extends Node2D



#ENEMIE MELEE ATTACK ------------------------------------------
func _on_melee_hit_body_entered(body: Node2D) -> void:
	if body.name == "PlayerCharacter":
		Player.currentHP -= 1
		$EnemyCharacter/AnimatedSprite2D.play("attack_animation")
		await get_tree().create_timer(0.5).timeout
		$EnemyCharacter/AnimatedSprite2D.play("default")

# --------------------------------------------------------------

#ENEMIE MOVEMENT -----------------------------------------------
@export var speed: float = randf_range(100.0, 150.0)
var velocity: Vector2 = Vector2.ZERO
var follow = false
var change_direction_time: float = 2.0
var time_passed: float = 0.0
var wait_time: float = 0.0
var wait_time_direction: float = 0.0

var Robert
var Robertposx
var Robertposy

func _ready():
	randomize()
	velocity = get_random_direction() * speed
	RoomGeneration.enemyamount = RoomGeneration.enemyamount +1

func _physics_process(delta: float):
	position += velocity * delta
	wait_time_direction = randf_range(1.0, 3.0)
	time_passed += delta
	if time_passed >= change_direction_time:
		#velocity = Vector2(0,0)
		wait_time += delta
		if wait_time >= wait_time_direction:
			velocity = get_random_direction() * speed
			time_passed = 0.0
			wait_time = 0.0

	if position.x < 0 or position.x > get_viewport_rect().size.x:
		velocity.x *= -1
	if position.y < 0 or position.y > get_viewport_rect().size.y:
		velocity.y *= -1
		
	# Follow Player ------------------------
	if(follow == true):
		Robertposx = Robert.position.x - position.x
		Robertposy = Robert.position.y - position.y
		velocity = Vector2(Robertposx, Robertposy) * 0.6
		print(velocity)
func get_random_direction() -> Vector2:
	var directions = [
		Vector2(1, 0),   
		Vector2(-1, 0),  
		Vector2(0, 1),   
		Vector2(0, -1)   
	]
	return directions[randi() % directions.size()]

# ---------------------------------------------------------------

func _on_tree_exited() -> void:
	RoomGeneration.enemyamount = RoomGeneration.enemyamount -1

func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.name == "PlayerCharacter"):
		Robert = body
		follow = true
		
