extends CharacterBody2D

@onready var animation = $AnimationPlayer
@onready var sprite =$Sprite2D

@export var speed = 340.0
@export var jump_height = -650.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var attacking = false

func _unhandled_input(event : InputEvent)-> void:
	if Input.is_action_just_pressed("ui_accept"):
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"),"start")
		return


func _process(_delta):
	if Input.is_action_just_pressed("attack1"):
		attack()
		
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	if Input.is_action_pressed("Left"):
		sprite.scale.x = abs(sprite.scale.x) * -1
		#$AttackArea.scale.x = abs(sprite.scale.x) * -1
	if Input.is_action_pressed("Right"):
		sprite.scale.x = abs(sprite.scale.x)
		$AttackArea.scale.x = abs(sprite.scale.x)
	


	if Input.is_action_just_pressed("Up") and is_on_floor():
		velocity.y = jump_height

	var direction = Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	update_animation()
	move_and_slide()

func attack():
	var overlapping_objects = $AttackArea.get_overlapping_areas()
	for area in overlapping_objects:
		var parent = area.get_parent()
		parent.queue_free()
	
	attacking = true
	animation.play("attack1")
	

func attack2():
	var overlapping_objects = $AttackArea.get_overlapping_areas()
	for area in overlapping_objects:
		var parent = area.get_parent()
		print(parent.name)
	
	attacking = true
	animation.play("attack1")

func update_animation():
	if !attacking:
			if velocity.x != 0:
				animation.play("running")
			else:
				animation.play("idle")
			if velocity.y < 0:
				animation.play("jump")
			if velocity.y > 0:
				animation.play("fall")
