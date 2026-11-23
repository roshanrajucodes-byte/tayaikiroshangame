extends Control
@onready var label: Label = $Label
@onready var event_bar: TextureRect =$EventBar



func _on_event_bar_bonus_done() -> void:
	label.text = "Bonus"
	_reset()

func _on_event_bar_fail() -> void:
	label.text = "fail"
	_reset()


func _on_event_bar_normal_done() -> void:
	label.text = "normal"
	_reset()

func _on_event_bar_success_done() -> void:
	label.text = "success"
	_reset()
func _reset():
	await get_tree().create_timer(1).timeout
	event_bar.reset()
