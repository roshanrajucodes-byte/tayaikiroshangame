# minigame_texture_rect.gd
extends TextureRect
#TY TO MERCHANT-OF-LIFE ON THE TAIYAKI SLACK
signal minigame_finished(success: bool)
signal bonus_done()
signal fail()

@export var duration: float = 1.0
@export var indicator: TextureRect
var xEndPosition: float 
@export var bonusRangeX: Vector2 = Vector2(93.0, 120.0)

var is_moving: bool = false

func _ready() -> void:
	if indicator:
		xEndPosition = 0.0 - (indicator.size.x / 2)
		
	else:
		push_error("ERROR: No indicator assigned in the Inspector!")

func start() -> void:
	if not indicator:
		return
	visible = true
	indicator.position.x = size.x - (indicator.size.x / 2)
	indicator.position.y = (size.y / 2) - (indicator.size.y / 2)
	
	is_moving = true
	set_process(true)
	
	is_moving = true
	set_process(true)
	
func _process(delta: float) -> void:
	if not is_moving or not indicator:
		return
		
	if size.x <= 0:
		return
		
	indicator.position.x -= (size.x / duration) * delta
	
	# Time ran out without clicking -> Fail
	if indicator.position.x < xEndPosition:
		_finish()

func _input(event: InputEvent) -> void:
	if not is_moving:
		return
		
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_finish()

func _finish():
	is_moving = false
	set_process(false)
	
	var inBonusRange = _in_range(bonusRangeX)
	
	if inBonusRange:
		minigame_finished.emit(true)
		GameState.taiyaki_caught+=1
		print(GameState.taiyaki_caught)
		bonus_done.emit()
		print("you caught the tayaki")
	else:
		# Player failed (missed the zone or ran out of time)
		minigame_finished.emit(false)
		fail.emit()
	# Clean up and close the minigame overlay
	visible = false
	
func _in_range(eventRange: Vector2):
	if not indicator:
		return false
		
	var indicatorCenter = indicator.position.x + (indicator.size.x / 2)
	
	if indicatorCenter >= eventRange.x and indicatorCenter <= eventRange.y:
		return true
	else:
		return false
	
