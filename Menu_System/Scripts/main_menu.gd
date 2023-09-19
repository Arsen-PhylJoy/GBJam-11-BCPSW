extends Control

signal play_pressed()

func _ready():
	var playButton = $"VBoxContainer/Play Button"
	playButton.connect("pressed",self.play_button_pressed)

func _process(_delta):
	pass

func _input(event):
	if event.is_action_pressed("start"):
		emit_signal("play_pressed")

func play_button_pressed() -> void:
	emit_signal("play_pressed")
