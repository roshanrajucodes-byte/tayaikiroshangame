extends Area2D

@export var is_unlocked: bool = false
@export var wall_collision: CollisionShape2D
@export var locked_dialogue: DialogueResource
@export var locked_start: String = "locked"

func _ready() -> void:
	update_barrier()

func unlock() -> void:
	is_unlocked = true
	update_barrier()

func update_barrier() -> void:
	if wall_collision == null:
		push_warning("Wall Collision is not assigned in the Inspector on " + name)
		return
	wall_collision.set_deferred("disabled", is_unlocked)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not is_unlocked:
		if locked_dialogue:
			DialogueManager.show_dialogue_balloon(locked_dialogue, locked_start)
