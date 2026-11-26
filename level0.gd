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
	var current_scene_name = get_tree().current_scene.name
	var level_no =  int(current_scene_name.substr(5))
	level_no += 1 
	var path = "res://minigame2/level"+ str(level_no) +".tscn"
	print(path)
	if FileAccess.file_exists(path):
		get_tree().change_scene_to_file(path)
	else:
		print("MAKE IT GO BACK NOW CHUD")
