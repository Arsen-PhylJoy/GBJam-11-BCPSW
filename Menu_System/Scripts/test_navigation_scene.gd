extends Node

const scene = preload("res://Menu_System/Scenes/test_scene.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	var playButton = $"Main Menu/VBoxContainer/Play Button"
	
	playButton.pressed.connect(self.on_PlayButton_pressed)
	
	playButton.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_PlayButton_pressed():
	var instance = scene.instantiate()
	add_child(instance)
	
	$"Main Menu".visible = false
	$"Main Menu".set_process(false)
