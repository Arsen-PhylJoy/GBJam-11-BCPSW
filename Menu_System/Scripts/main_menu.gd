extends Control

signal game_started(start_level)

@export var start_level: PackedScene

func _ready():
	pass
	var playButton = $"VBoxContainer/Play Button"
	playButton.pressed.connect(self._on_play_button_pressed)

func _process(_delta):
	pass

func _input(event):
	if event is InputEventKey:
		if event.as_text_keycode() == "Enter":
			self._on_play_button_pressed()
		elif event.as_text_keycode() == "Escape":
			get_tree().quit()

func _on_play_button_pressed() -> void:
	emit_signal("game_started",start_level)
