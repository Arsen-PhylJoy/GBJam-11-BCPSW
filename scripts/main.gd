extends Node
@export var intro_scene: PackedScene
@export var main_scene: PackedScene
@export var level1: PackedScene

const intro_string: String = "Intro"
const menus_string: String = "Menus"
const level1_string: String = "Level1"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().root.size = Vector2(1000,900)
	get_tree().root.position = Vector2(100,100)
	load_scene(intro_scene,intro_string)
	get_node(intro_string).connect("intro_ended", self.load_menu)

func load_scene(scene: PackedScene,node_name: String)->void:
	var scene_instace = scene.instantiate()
	scene_instace.name = node_name
	add_child(scene_instace)
	
func remove_scene(node_name: String)->void:
	get_node(node_name).queue_free()

func load_menu() ->void:
	remove_scene(intro_string)
	load_scene(main_scene,menus_string)
	get_node(menus_string).connect("play_pressed",self.load_level1)

func load_level1()->void:
	remove_scene(menus_string)
	load_scene(level1,level1_string)
