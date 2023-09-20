extends Object

class_name SceneControl

var scenes: Array[SceneInfo]
var current_scene: SceneInfo = null

func _init(scene: SceneInfo = null):
	if scene != null:
		self.scenes.push_back(scene)

func add_scenes(scenes_to_add: Array[SceneInfo]):
	self.scenes.append_array(scenes_to_add)
	
func delete_scenes(scenes_to_delete: Array[SceneInfo]):
	var tmp: Array[SceneInfo] = []
	for _scene in self.scenes:
		if not scenes_to_delete.has(_scene.name):
			tmp.push_back(_scene)
	self.scenes = tmp
	
func get_scene_by_name(name: String) -> SceneInfo:
	var result: SceneInfo = null
	for scene in self.scenes:
		if scene.name == name:
			result = scene
			break
	return result
	
func set_current(scene: SceneInfo):
	self.current_scene = scene
	
func get_current() -> SceneInfo:
	return self.current_scene
