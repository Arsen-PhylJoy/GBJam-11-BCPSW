extends RigidBody2D

signal on_meteor_deleted(meteor)

@export_category("Meteorites' sprites")
@export var meteorite_textures: Array[Texture]

var rand: RandomNumberGenerator = RandomNumberGenerator.new()

	
func _ready() -> void:
	rand.randomize()
	$meteorite_animation.play("meteorite")
	$meteorite_sprite.texture = meteorite_textures[randi_range(0,meteorite_textures.size()-1)]

func _exit_tree() -> void:
	self.queue_free()
	
func _on_body_entered(body: Node) -> void:
	if(body.is_in_group("Ground")):
		emit_signal("on_meteor_deleted", self)

