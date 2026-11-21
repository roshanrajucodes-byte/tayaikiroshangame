extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast2d: RayCast2D = $RayCast2D
# this uses code from devdrache and his video https://www.youtube.com/watch?v=pCrHIMBgtgs 
#i used ai to write like 5 lines of code which he didnt show
#i hand wrote everything from his video into this script then placed it into ai to fix the part he didnt show
const TILE_SIZE: int = 16 
var onMove: bool = false
var currentDirection: Vector2 = Vector2.ZERO
var lastDirection: Vector2 = Vector2.DOWN 

func _physics_process(delta: float) -> void:
	if onMove:
		return
		
	_normal_movement()
	_set_animation()
	
	
	if currentDirection != Vector2.ZERO:
		lastDirection = currentDirection

func _normal_movement() -> void:
	var direction: Vector2 = Vector2.ZERO
	
	if Input.is_action_pressed("ui_up"):
		direction = Vector2.UP
	elif Input.is_action_pressed("ui_down"):
		direction = Vector2.DOWN
	elif Input.is_action_pressed("ui_left"):
		direction = Vector2.LEFT
	elif Input.is_action_pressed("ui_right"):
		direction = Vector2.RIGHT
	
	currentDirection = direction
	
	if direction != Vector2.ZERO:
		ray_cast2d.target_position = direction * TILE_SIZE
		ray_cast2d.force_raycast_update()
		
		if ray_cast2d.is_colliding():
			return
		
		var targetPosition: Vector2 = global_position + direction * TILE_SIZE
		_move_to(targetPosition)
		
func _move_to(targetPosition: Vector2) -> void:
	onMove = true
	
	var tween = create_tween()
	tween.tween_property(self, "global_position", targetPosition, 0.3)
	await tween.finished
	
	onMove = false

func _set_animation() -> void:
	if currentDirection.x > 0:
		animated_sprite_2d.flip_h = false
		animated_sprite_2d.play("run_side")
	elif currentDirection.x < 0:
		animated_sprite_2d.flip_h = true
		animated_sprite_2d.play("run_side")
	elif currentDirection.y < 0:
		animated_sprite_2d.play("run_up")
	elif currentDirection.y > 0:
		animated_sprite_2d.play("run_down")
	else:
		# Fixed typos: changed "lastDiraction" to "lastDirection"
		if lastDirection.x != 0:
			animated_sprite_2d.play("idle_side")
		elif lastDirection.y < 0:
			animated_sprite_2d.play("idle_up")
		elif lastDirection.y > 0:
			animated_sprite_2d.play("idle_down")
