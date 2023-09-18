extends Control

signal game_started(start_level)

@export var start_level: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	var quitButton = $"VBoxContainer/Quit Button"
	
	quitButton.pressed.connect(self.on_QuitButton_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_QuitButton_pressed():
	get_tree().quit()

func _on_play_button_pressed() -> void:
	emit_signal("game_started",start_level)
