extends Area2D

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"

func _ready() -> void:
	print("1. Area2D is ready! Monitoring: ", monitoring)
	print("2. Dialogue resource assigned: ", dialogue_resource)

func _on_body_entered(body: Node2D) -> void:
	print("3. Something entered: ", body.name, " | Groups: ", body.get_groups())
	DialogueManager.show_dialogue_balloon(dialogue_resource, dialogue_start)
