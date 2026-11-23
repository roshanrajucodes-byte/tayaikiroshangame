extends TextureRect

signal bonus_done()
signal fail()

@export var duration: float = 1.0
@export var indicator: TextureRect

var xEndPosition: float 
@export var bonusRangeX: Vector2 = Vector2(28.0, 36.0)

var is_moving: bool = false


func _ready() -> void:
	if indicator:
		xEndPosition = 0.0 - (indicator.size.x / 2)
		start()
	else:
		push_error("ERROR: No indicator assigned in the Inspector!")

func start() -> void:
	if not indicator:
		return
		
	indicator.position.x = size.x - (indicator.size.x / 2)
	indicator.position.y = (size.y / 2) - (indicator.size.y / 2)
	
	is_moving = true
	set_process(true)
	
func _process(delta: float) -> void:
	if not is_moving or not indicator:
		return
		
	if size.x <= 0:
		return
		
	indicator.position.x -= (size.x / duration) * delta
	
	# When time runs out without clicking, it now triggers a fail directly
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
		bonus_done.emit()
	else:
		fail.emit()
	
func _in_range(eventRange: Vector2):
	if not indicator:
		return false
		
	var indicatorCenter = indicator.position.x + (indicator.size.x / 2)
	
	if indicatorCenter >= eventRange.x and indicatorCenter <= eventRange.y:
		return true
	else:
		return false
	
func reset():
	start()
