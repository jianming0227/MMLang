extends Area2D

@export var dialogue_resources: DialogueResource
@export var dialogue_start: String = "Mazai"

func action() -> void:
	DialogueManager.show_example_dialogue_balloon(dialogue_resources,dialogue_start)
