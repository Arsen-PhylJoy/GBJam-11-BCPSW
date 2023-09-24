extends Control

signal unpause

func _ready():
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	$"Resume Button".connect("button_down",self._on_button_down)
	$"Exit Button".connect("button_down",self._on_button_down)
	
func _process(_delta):
	if not Global.isDeafeated:
		if $PauseTimer.is_stopped() == true:
			if Input.is_action_pressed("pause"):
				print("P pressed during pause screen")
				get_tree().paused = false
				self.hide()
				emit_signal("unpause")

func play_resume_audio():
	$"resume-button-audio".play()
	
func play_pause_audio():
	$"pause-button-audio".play()
	
func _on_button_down()->void:
	$pause_menu_click.play()
	await $pause_menu_click.finished
