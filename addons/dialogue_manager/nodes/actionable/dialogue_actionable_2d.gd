@tool

@icon("uid://ja67jst5iqyy")

## A special [Area2D] node to hold information about starting dialogue.
##
## Assuming [code]dialogue_resource[/code] and [code]cue[/code] have been configured you can
## call [code]action()[/code] on this node at runtime to start dialogue.
class_name DialogueActionable2D extends Area2D



@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		DialogueManager.show_dialogue_balloon(dialogue_resource, dialogue_start)
