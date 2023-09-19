extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$intro_scene_animation.play("title_animation")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
