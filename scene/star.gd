extends Area2D

@onready var main_character = $"../main_character"
@onready var collision_shape_2d = $CollisionShape2D

func _on_body_entered(body):
	if (body.name == collision_shape_2d):
		queue_free()
