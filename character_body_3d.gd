extends CharacterBody3D

@export var mouse_sensitivity: float = 0.009
@onready var animP = $"../AnimationPlayer"
const SPEED = 5.0
const JUMP_VELOCITY = 4.5

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	handle_movement(delta)
	handle_rotation(delta)
	update_animation()

func handle_movement(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("right", "left", "backward", "forward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func handle_rotation(delta: float) -> void:
	if Input.mouse_mode != 2:
		pass
	else:
		var mouse_delta = Input.get_last_mouse_velocity()
		rotation_degrees.y -= mouse_delta.x * mouse_sensitivity
func update_animation() -> void:
	if not is_on_floor():
		if not animP.is_playing() or animP.current_animation != "anims/jump":
			animP.play("anims/jump", -1,2.0)
	elif velocity.length() > 0.1:  # Threshold to switch to walking animation
		if not animP.is_playing() or animP.current_animation != "anims/strafe_left" and Input.is_action_pressed("left"):
			animP.stop()
			animP.play("anims/strafe_left")
		elif not animP.is_playing() or animP.current_animation != "anims/strafe_right" and Input.is_action_pressed("right"):
			animP.stop()
			animP.play("anims/strafe_right")
		elif not animP.is_playing() or animP.current_animation != "anims/walk" and Input.is_action_pressed("forward"):
			animP.stop()
			animP.play("anims/walk")
		elif not animP.is_playing() or animP.current_animation != "anims/walk" and Input.is_action_pressed("backward"):
			animP.stop()
			animP.play("anims/walk")
	else:
		if not animP.is_playing() or animP.current_animation != "anims/idle":
			animP.play("anims/idle")
