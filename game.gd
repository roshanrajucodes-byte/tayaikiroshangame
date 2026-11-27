extends Node2D


func _ready():
	if GameState.returning_from_minigame:
		$player.global_position = GameState.saved_player_position
		GameState.returning_from_minigame = false
