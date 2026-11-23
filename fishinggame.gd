extends Area2D

@export var label: Label

func _ready() -> void:
	label.visible = false

func _on_body_entered(body: Node2D) -> void:
	label.visible = true
	if Input.is_action_pressed("e"):
		pass

func _on_body_exited(body: Node2D) -> void:
	label.visible = false
