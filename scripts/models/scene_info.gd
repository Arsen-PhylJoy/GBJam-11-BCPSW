extends Object

class_name SceneInfo

enum Layer {
	UI,
	OVER,
	FOREGROUND,
	BACKGROUND,
}

enum Type {
	MENU,
	LEVEL,
	ANIMATION,
}

# Properties
var name: String
var id: int
var layer: Layer
var type: Type
var packed_scene: PackedScene

# Constructor
func _init(_name: String, _id: int, _layer: Layer, _type: Type, _packed_scene: PackedScene):
	self.name = _name
	self.id = _id
	self.layer = _layer
	self.type = _type
	self.packed_scene = _packed_scene
