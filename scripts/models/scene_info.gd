extends Object

class_name SceneInfo

# Properties
var name: String
var id: int
var layer: Global.Layer
var type: Global.Type
var packed_scene: PackedScene

# Constructor
func _init(_name: String, _id: int, _layer: Global.Layer, _type: Global.Type, _packed_scene: PackedScene):
	self.name = _name
	self.id = _id
	self.layer = _layer
	self.type = _type
	self.packed_scene = _packed_scene
