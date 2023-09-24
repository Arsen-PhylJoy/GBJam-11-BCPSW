extends Control

signal exit


func _ready():
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	$"exit".connect("button_down",self._on_button_down)
	$score.text = str(Global.score)
	
func _process(delta: float) -> void:
	if(win)

func _on_exit()->void:
	get_tree().pause = false
	emit_signal("exit")

func _on_button_down()->void:
	emit_signal("unpause")
