# trigger_area.gd
extends Area2D

@export var minigame_scene: PackedScene = preload("res://EventBar.tscn")

var player_in_range: bool = false
var active_minigame: Node = null




func open_minigame() -> void:
	active_minigame = minigame_scene.instantiate()
	
	# Add the TextureRect minigame directly to your CanvasLayer
	get_tree().current_scene.get_node("MinigameLayer").add_child(active_minigame)
	
	active_minigame.minigame_finished.connect(_on_minigame_finished)
	
	get_tree().paused = true

func _on_minigame_finished(success: bool) -> void:
	get_tree().paused = false
	active_minigame = null
	if success:
		print("Minigame completed successfully!")
