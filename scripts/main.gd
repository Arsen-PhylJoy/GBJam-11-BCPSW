extends Node

var scenes: SceneControl = SceneControl.new()
var scene_names = {GameScene.INTRO: "intro", GameScene.MAIN_MENU: "main_menu", GameScene.LEVEL_1: "level_1"}
enum GameScene {
	INTRO,
	MAIN_MENU,
	LEVEL_1
}
	
@export var intro_scene_pk: PackedScene
@export var main_menu_scene_pk: PackedScene
@export var level_1_scene_pk: PackedScene

func _main_preprocesses() -> void:
	_create_scenes_info()

func _create_scenes_info() -> void:

	var intro_scene = SceneInfo.new(scene_names[GameScene.INTRO], 0, SceneInfo.Layer.OVER, SceneInfo.Type.ANIMATION, intro_scene_pk)
	var main_menu_scene = SceneInfo.new(scene_names[GameScene.MAIN_MENU], 1, SceneInfo.Layer.UI, SceneInfo.Type.MENU, main_menu_scene_pk)
	var level_1_scene = SceneInfo.new(scene_names[GameScene.LEVEL_1], 2, SceneInfo.Layer.OVER, SceneInfo.Type.LEVEL, level_1_scene_pk)
	scenes.add_scenes([intro_scene, main_menu_scene, level_1_scene])

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_main_preprocesses()
	get_tree().root.size = Vector2(160*2,144*2)
	get_tree().root.position = Vector2(100,100)
	
	var intro_scene = self.scenes.get_scene_by_name(scene_names[GameScene.INTRO])
	load_scene(intro_scene)
	get_node(intro_scene.name).connect("intro_ended", self.load_menu)

func load_scene(scene: SceneInfo)->void:
	var current_scene = self.scenes.get_current()
	if current_scene != null:
		remove_scene(current_scene)
	self.scenes.set_current(scene)
	var scene_instace = scene.packed_scene.instantiate()
	scene_instace.name = scene.name
	add_child(scene_instace)
	
func remove_scene(scene: SceneInfo)->void:
	get_node(scene.name).queue_free()

func load_menu() ->void:
	var main_menu_scene = scenes.get_scene_by_name(scene_names[GameScene.MAIN_MENU])
	load_scene(main_menu_scene)
	get_node(main_menu_scene.name).connect("play_pressed",self.load_level1)

func load_level1()->void:
	var level_1_scene = scenes.get_scene_by_name(scene_names[GameScene.LEVEL_1])
	load_scene(level_1_scene)
	var level_1_node = get_node(level_1_scene.name)
	level_1_node.connect("exit_game", self.load_level1_from_pause)
	level_1_node.connect("defeat", self.load_menu)
	
func load_level1_from_pause() -> void:
	print("load level 1 from pause")
#	remove_scene(level1_string)
#	load_scene(main_scene, menus_string)
#	get_node(menus_string).connect("play_pressed",self.load_level1)
