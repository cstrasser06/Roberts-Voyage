extends CharacterBody2D
@export var inventoryData: InventoryData



const SPEED = 300.0
var canattack = false;

func _ready() -> void:
	inventoryData = preload("res://Inventory/test_inv.tres")


func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionx := Input.get_axis("MOVELEFT", "MOVERIGHT")
	var directiony := Input.get_axis("MOVEUP", "MOVEDOWN")
	
	if Input.is_action_pressed("MOVELEFT"):
		$AnimatedSprite2D.play("robert_walk")
		$AnimatedSprite2D.flip_h = true;
		
	elif Input.is_action_pressed("MOVEDOWN") || Input.is_action_pressed("MOVEUP") || Input.is_action_pressed("MOVERIGHT"):
		$AnimatedSprite2D.play("robert_walk")
		$AnimatedSprite2D.flip_h = false;
			
	else:
		$AnimatedSprite2D.play("robert_idle")
	
	
	
	if directionx || directiony:
		velocity.x = directionx * SPEED
		velocity.y = directiony * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	if position.x < 0 or position.x > get_viewport_rect().size.x or position.y < 0 or position.y > get_viewport_rect().size.y:
		global_position = Vector2(500,300)

	
	move_and_slide()


	
	# MELEE ATTACK ---------------------
	$Area2D/CollisionShape2D.disabled=true
	
	if Input.is_action_pressed("Attack"):
		$Area2D/CollisionShape2D.disabled = false	
		canattack = true;
	else :
		$Area2D/CollisionShape2D.disabled = true
		canattack = false;
	#-------------------------------------	
		
	# HitBox movement --------------------
	if Input.is_action_pressed("MOVELEFT"):
		$Area2D.position = Vector2(0,0)
		$Area2D.position = Vector2(-110,0)		
		
	if Input.is_action_pressed("MOVERIGHT"):
		$Area2D.position = Vector2(0,0)
		$Area2D.position = Vector2(110,0)	
		
	if Input.is_action_pressed("MOVEDOWN"):
		$Area2D.position = Vector2(0,0)
		$Area2D.position = Vector2(0,100)
	
	if Input.is_action_pressed("MOVEUP"):
		$Area2D.position = Vector2(0,0)
		$Area2D.position = Vector2(0,-100)	
	# --------------------------------------

# MELEE ON ENEMIE ----------------------------	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if canattack == true && body.name == "EnemyCharacter":
		body.health -= 1
# ------------------------------------------------
			

		
 
