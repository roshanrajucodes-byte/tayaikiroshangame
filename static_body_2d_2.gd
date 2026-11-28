extends StaticBody2D


@onready var collision = $CollisionShape2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GameState.talked_to_gary_final:
		collision.set_deferred("disabled",true)
	else:
		collision.set_deferred("disabled",false)
