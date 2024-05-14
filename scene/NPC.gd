extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add gravity if the character is not on the floor.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump with the 'jump' action linked to the Up arrow key.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction from default UI left and right actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	
	# Handle horizontal movement and sprite flipping.
	if direction != 0:
		velocity.x = direction * SPEED
		$Sprite2D.flip_h = direction < 0  # Flip sprite when moving left
	else:
		# Gradually reduce horizontal velocity to 0 if no input is detected.
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Move the character.
	move_and_slide()
