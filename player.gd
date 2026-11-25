extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast2d: RayCast2D = $RayCast2D


var lastDirection: Vector2 = Vector2.DOWN

func _physics_process(delta: float) -> void:
	var dir: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = dir * 50.0
	move_and_slide()
	
	
	if dir != Vector2.ZERO:
		lastDirection = dir
	
	
	if Input.is_action_pressed("ui_right"):
		animated_sprite_2d.flip_h = false
		animated_sprite_2d.play("run_side")
	elif Input.is_action_pressed("ui_left"):
		animated_sprite_2d.flip_h = true
		animated_sprite_2d.play("run_side")
	elif Input.is_action_pressed("ui_up"):
		animated_sprite_2d.play("run_up")
	elif Input.is_action_pressed("ui_down"):
		animated_sprite_2d.play("run_down")
	else:
		
		if lastDirection.x != 0:
			animated_sprite_2d.play("idle_side")
		elif lastDirection.y < 0:
			animated_sprite_2d.play("idle_up")
		elif lastDirection.y > 0:
			animated_sprite_2d.play("idle_down")
