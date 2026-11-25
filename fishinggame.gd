extends Area2D

@export var label: Label
@onready var event_bar: TextureRect = get_tree().current_scene.find_child("EventBar", true, false)

var player_in_range: bool = false
var is_minigame_active: bool = false

func _ready() -> void:
	if label:
		label.visible = false
	
	if event_bar:
		event_bar.visible = false
		
		
		if not event_bar.is_connected("bonus_done", _on_minigame_won):
			event_bar.bonus_done.connect(_on_minigame_won)
		if not event_bar.is_connected("fail", _on_minigame_lost):
			event_bar.fail.connect(_on_minigame_lost)
	

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		player_in_range = true
		print("Player entered the Area2D range.")
		if label and not is_minigame_active:
			label.visible = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "player":
		player_in_range = false
		print(" Player left the Area2D range.")
		if label:
			label.visible = false

func _unhandled_input(event: InputEvent) -> void:
	if player_in_range and event.is_action_pressed("e") and not is_minigame_active:
		print("e pressed starting minigame")
		start_minigame()

func start_minigame() -> void:
	is_minigame_active = true

	if label:
		label.visible = false

	get_tree().paused = true

	if event_bar:
		var minigame_layer = get_tree().current_scene.find_child("MinigameLayer", true, false)

		if minigame_layer:
			minigame_layer.visible = true
			minigame_layer.process_mode = Node.PROCESS_MODE_WHEN_PAUSED

		event_bar.visible = true
		event_bar.process_mode = Node.PROCESS_MODE_WHEN_PAUSED

		if event_bar.has_method("start"):
			event_bar.start()
			
		
		
	# Pause the rest of the game world
	get_tree().paused = true

func _on_minigame_won() -> void:
	
	close_minigame()

func _on_minigame_lost() -> void:
	
	close_minigame()

func close_minigame() -> void:
	print("CLOSE MINIGAME CALLED")

	get_tree().paused = false
	is_minigame_active = false

	if event_bar:
		event_bar.visible = false

	if player_in_range and label:
		label.visible = true

	print("Game paused status: ", get_tree().paused)
