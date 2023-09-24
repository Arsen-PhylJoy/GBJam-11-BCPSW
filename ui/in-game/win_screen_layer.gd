extends CanvasLayer


signal exit

func _ready():
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	
func set_score(score: int)->void:
	$win_screen/score.text = str(score)
	$win_screen/win.play()
	get_tree().paused = true

func _on_exit_button_button_down() -> void:
	$win_screen/click.play()
	get_tree().paused = false
	emit_signal("exit")
