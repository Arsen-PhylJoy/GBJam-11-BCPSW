extends Node
# make a field for position

# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_PAUSABLE
	print("enters the pause scene")
	
	var pause_screen = $"Pause Screen"
	pause_screen.hide()
	
	var resume_button = $"Pause Screen/Resume Button"
	resume_button.pressed.connect(self.on_resume_button_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	print("process the pause scene")
	if $"PauseTimer".is_stopped() == true:
		if Input.is_action_pressed("pause"):
			# store position and set positions to zero
			print("P pressed during unpaused")
			on_pause_button_pressed()
		
	

func on_pause_button_pressed():
	get_tree().paused = true
	$"Pause Screen".show()
	$"Pause Screen/PauseTimer".start()
	$"Pause Screen/Resume Button".grab_focus()

func on_resume_button_pressed():
	$"Pause Screen".hide()
	get_tree().paused = false


func _on_pause_screen_unpause():
	# reapply stash
	print("unpaused by pressing pause button")
	$PauseTimer.start()
