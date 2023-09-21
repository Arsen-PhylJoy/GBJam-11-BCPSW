extends Control

signal play_pressed()

func _ready():
	pass

func _process(_delta):
	pass

func _input(event):
	if event.is_action_pressed("start"):
		emit_signal("play_pressed")

func _on_play_button_pressed() -> void:
	emit_signal("play_pressed")
