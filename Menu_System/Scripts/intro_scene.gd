extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var anim = $intro_scene_animation
	anim.play("title_animation")
	anim.connect("animation_finished", self._on_intro_scene_ended)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_intro_scene_ended(message):
	print("Scene ended")
