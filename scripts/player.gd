extends CharacterBody2D

@onready var player_anim: AnimatedSprite2D = $PlayerAnim
@onready var player_collision: CollisionShape2D = $PlayerCollision

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "rigth")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if is_on_floor():
		if direction > 0:
			player_anim.flip_h = false
			player_anim.play("run")
		elif direction < 0: 
			player_anim.flip_h = true
			player_anim.play("run")
		else:
			player_anim.play("idle")
	else:
		player_anim.play("jump")
		
	move_and_slide()
	
	
