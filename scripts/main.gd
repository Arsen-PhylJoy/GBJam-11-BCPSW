extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func load_scene(scene: PackedScene)->void:
	add_child(scene.instantiate())
	
func remove_scene(node_path : NodePath)->void:
	remove_scene(node_path)
	get_node(node_path).queue_free()

func _on_main_menu_game_started(level) -> void:
	remove_child($"Main Menu")
	load_scene(level)
