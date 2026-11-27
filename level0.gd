extends Node2D
@onready var spots: Node2D = $spots

func _process(delta: float) -> void:
	check_spots()

func check_spots():
	var number_of_spots = spots.get_child_count()
	
	for each_spot in spots.get_children():
		if each_spot.occupied == true:
			number_of_spots -= 1
	if number_of_spots ==0:
		go_next_level()
		
func go_next_level():
	var current_path = get_tree().current_scene.scene_file_path

	if current_path.ends_with("level0.tscn"):
		get_tree().change_scene_to_file("res://minigame2/level1.tscn")

	elif current_path.ends_with("level1.tscn"):
		get_tree().change_scene_to_file("res://minigame2/level2.tscn")

	elif current_path.ends_with("level2.tscn"):
		get_tree().change_scene_to_file("res://game.tscn")
