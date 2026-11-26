extends Area2D

var occupied:bool = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("box"):
		occupied = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("box"):
		occupied = false
