extends CharacterBody2D


const JUMP_VELOCITY = -400.0
const ACC = 300
const MAX_SPEED = 500.0
const FRICTION = 1000

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("left","right")
	# Add the gravity.
	if not is_on_floor():
		if not is_on_wall():
			velocity += get_gravity() * delta
		if is_on_wall():
			if velocity.y > 0 && direction != 0:
				velocity += get_gravity() * delta/5
			else:
				velocity += get_gravity() * delta
	
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	
	if direction:
		velocity.x = move_toward(velocity.x, MAX_SPEED*direction, ACC*delta)
	else:
		if is_on_floor():
			velocity.x = move_toward(velocity.x, 0, FRICTION*delta)
	if velocity.x >= MAX_SPEED:
		velocity.x = MAX_SPEED
	if velocity.x <= -MAX_SPEED:
		velocity.x = -MAX_SPEED
	move_and_slide()
