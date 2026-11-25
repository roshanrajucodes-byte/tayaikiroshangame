extends CanvasLayer

var stashednumber = 0

func _ready() -> void:
	$Label.text = str(GameState.taiyaki_caught)
	stashednumber = GameState.taiyaki_caught


func _process(delta: float) -> void:
	if stashednumber != GameState.taiyaki_caught:
		$Label.text = str(GameState.taiyaki_caught)
		stashednumber = GameState.taiyaki_caught
