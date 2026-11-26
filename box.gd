extends CharacterBody2D

const TILESIZE = 16
@onready var ray: RayCast2D = $RayCast2D

var inputs = {
	"move_up" : Vector2.UP,
	"move_left" : Vector2.LEFT,
	"move_down" : Vector2.DOWN,
	"move_right" : Vector2.RIGHT,
	}

			
func can_move(dir):
	
	var vector_pos = inputs[dir]*TILESIZE
	ray.target_position=vector_pos
	ray.force_raycast_update()
	if not ray.is_colliding():
		position += vector_pos
		return true
	return false
	animation
func animation():
	var tween = create_tween()
	tween.tween_property(self,"scale",Vector2(1,1.2),0.05)
	tween.tween_property(self,"scale",Vector2(1.2,1),0.05)
	tween.tween_property(self,"scale",Vector2(1,1),0.05)
