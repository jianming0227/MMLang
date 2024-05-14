extends CharacterBody2D
const TrapMonster = preload("res://trap_monster.gd")

func _ready():
	pass

func _on_top_checker_body_entered(body):
	if(body.name=="Player"):
		queue_free()
