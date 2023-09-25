extends Node

var game_window_scale = 1

var scenes: SceneControl = SceneControl.new()
	
@export var intro_scene_pk: PackedScene
@export var main_menu_scene_pk: PackedScene
@export var level_1_scene_pk: PackedScene

@export var transition_pk: PackedScene

func _main_preprocesses() -> void:
	Global.init_score_data()
	_create_scenes_info()

func _create_scenes_info() -> void:
	var intro_scene = SceneInfo.new(Global.SceneName[Global.Scene.INTRO], 0, Global.Layer.OVER, Global.Type.ANIMATION, intro_scene_pk)
	var main_menu_scene = SceneInfo.new(Global.SceneName[Global.Scene.MAIN_MENU], 1, Global.Layer.UI, Global.Type.MENU, main_menu_scene_pk)
	var level_1_scene = SceneInfo.new(Global.SceneName[Global.Scene.LEVEL_1], 2, Global.Layer.OVER, Global.Type.LEVEL, level_1_scene_pk)
	scenes.add_scenes([intro_scene, main_menu_scene, level_1_scene])

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_main_preprocesses()
	get_tree().root.size = Vector2(640,576)
	
	var intro_scene = self.scenes.get_scene_by_name(Global.SceneName[Global.Scene.INTRO])
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
	await Global.fade(false)
	
func remove_scene(scene: SceneInfo)->void:
	await Global.fade(true)
	get_node(scene.name).queue_free()

func load_menu() ->void:
	var main_menu_scene = scenes.get_scene_by_name(Global.SceneName[Global.Scene.MAIN_MENU])
	await load_scene(main_menu_scene)
	get_node(main_menu_scene.name).connect("play_pressed",self.load_level1)

func load_level1()->void:
	Global.score.add_levels([Global.Level.LEVEL_1])
	var level_1_scene = scenes.get_scene_by_name(Global.SceneName[Global.Scene.LEVEL_1])
	await load_scene(level_1_scene)
	var level_1_node = get_node(level_1_scene.name)
	level_1_node.connect("exit_game", self.load_menu)
	level_1_node.connect("defeat", self.load_menu)
	level_1_node.connect("win", self.load_menu)
	
