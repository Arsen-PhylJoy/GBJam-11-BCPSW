extends Node

var game_window_scale = 1

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

@export var transition_pk: PackedScene

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
	get_tree().root.size = Vector2(160,144)
	
	var intro_scene = self.scenes.get_scene_by_name(scene_names[GameScene.INTRO])
	await load_scene(intro_scene)
	get_node(intro_scene.name).connect("intro_ended", self.load_menu)

func _process(_delta) -> void:
	if Input.is_action_just_released("ui_page_up"):
		game_window_scale += 1
		self._set_game_window_size()

	elif Input.is_action_just_released("ui_page_down"):
		game_window_scale -= 1
		self._set_game_window_size()

func _set_game_window_size():
	get_tree().root.size = Vector2(160 * self.game_window_scale, 144 * self.game_window_scale)
	await get_tree().create_timer(1).timeout

func load_scene(scene: SceneInfo)->void:
	var current_scene = self.scenes.get_current()
	if current_scene != null:
		await remove_scene(current_scene)
	self.scenes.set_current(scene)
	var scene_instace = scene.packed_scene.instantiate()
	scene_instace.name = scene.name
	add_child(scene_instace)
	await fade(false)
	
func remove_scene(scene: SceneInfo)->void:
	await fade(true)
	get_node(scene.name).queue_free()

func load_menu() ->void:
	var main_menu_scene = scenes.get_scene_by_name(scene_names[GameScene.MAIN_MENU])
	await load_scene(main_menu_scene)
	get_node(main_menu_scene.name).connect("play_pressed",self.load_level1)

func load_level1()->void:
	var level_1_scene = scenes.get_scene_by_name(scene_names[GameScene.LEVEL_1])
	await load_scene(level_1_scene)
	var level_1_node = get_node(level_1_scene.name)
	level_1_node.connect("exit_game", self.load_menu)
	level_1_node.connect("defeat", self.load_menu)

##If true->fade in else fade out
func fade(fade_flag: bool) -> void:
	var transition_screen = transition_pk.instantiate()
	add_child(transition_screen)
	if(fade_flag):
		await transition_screen.start_fade_in()
	else:
		await transition_screen.start_fade_out()
