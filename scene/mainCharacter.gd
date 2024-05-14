extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var double_jump_velocity : float = -400
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var actionable_finder: Area2D = $ActionableFinder

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped : bool = false

func _unhandled_input(event: InputEvent) -> void:
		if event.is_action_pressed("ui_accept"):
			var actionables = actionable_finder.get_overlapping_areas()
			if actionables.size()>0:
				actionables[0].action()
				return

func _physics_process(delta):
	if(velocity.x > 1 || velocity.x < -1):
		animated_sprite_2d.animation = "running"
	else:
		animated_sprite_2d.animation = "idle"
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		animated_sprite_2d.animation = "jumping"
	else: 
		has_double_jumped = false

	# Handle jump and double jump
	if Input.is_action_just_pressed("Up"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		elif not has_double_jumped:
			velocity.y+= double_jump_velocity
			has_double_jumped = true

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_vector("Left", "Right","Up","Down")
	if direction:
		velocity.x = direction.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()   
						   

	var isLeft = velocity.x < 0
	animated_sprite_2d.flip_h = isLeft
		
	
	
	
	
	
	
	
	
	

		
	
	
	
