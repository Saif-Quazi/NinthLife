extends CharacterBody2D

const SPEED = 180.0
const JUMP_FORCE = -420.0
const GRAVITY = 900.0
const ACCELERATION = 15.0
const FRICTION = 1.5

func _physics_process(delta: float) -> void:
	_apply_gravity(delta)
	_handle_jump()
	_handle_movement()
	move_and_slide()

func _apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += GRAVITY * delta

func _handle_jump() -> void:
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_FORCE

func _handle_movement() -> void:
	var direction := Input.get_axis("move_left", "move_right")
	if direction != 0:
		velocity.x = lerp(velocity.x, direction * SPEED, ACCELERATION * get_physics_process_delta_time())
	else:
		velocity.x = lerp(velocity.x, 0.0, FRICTION * get_physics_process_delta_time())
