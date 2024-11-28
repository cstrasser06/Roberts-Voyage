extends CharacterBody2D
@export var inventoryData: InventoryData

const SPEED = 300.0

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
