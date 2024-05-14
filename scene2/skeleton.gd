extends CharacterBody2D


var SPEED = 300.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var facing_right = false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	velocity.x = SPEED
	move_and_slide()
		
		
