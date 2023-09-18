extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$title_animation_test_player.play("title_animation_test")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
