extends Control

signal unpause
#signal exit

# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if $PauseTimer.is_stopped() == true:
		if Input.is_action_pressed("pause"):
			print("P pressed during pause screen")
			get_tree().paused = false
			self.hide()
			emit_signal("unpause")
