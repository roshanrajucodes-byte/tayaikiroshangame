extends Node2D

@export var target: Node2D
@export var player: = get_parent()
@onready var glep = get_tree().current_scene.find_child("Glep", true, false)
@onready var fishing_area = get_tree().current_scene.find_child("FishingArea", true, false)



func _process(delta: float) -> void:
	if GameState.talked_to_glep:
		target= fishing_area
	else:
		target = glep
	if not target or not player:
		return
	
	visible = true
	

	global_position = player.global_position + Vector2(0, -15)
	

	var direction = target.global_position - global_position
	rotation = direction.angle()
	
func set_target(new_target: Area2D):
	target = new_target
	visible = true
	
func hide_arrow():
	visible = false
