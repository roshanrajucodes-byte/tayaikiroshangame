extends Area2D
var player_in_range: bool = false
@export var dialogue_resource: DialogueResource
@export var dialogue_start: String = "start"
@onready var arrow = get_tree().current_scene.find_child("ObjectiveArrow", true, false)
func _ready() -> void:
	print("1. Area2D is ready! Monitoring: ", monitoring)
	print("2. Dialogue resource assigned: ", dialogue_resource)

func _on_body_entered(body: Node2D) -> void:
	print("3. Something entered: ", body.name, " | Groups: ", body.get_groups())
	DialogueManager.show_dialogue_balloon(dialogue_resource, dialogue_start)
	if body.name == "player":
		player_in_range = true
		
		if arrow:
			arrow.hide_arrow()
