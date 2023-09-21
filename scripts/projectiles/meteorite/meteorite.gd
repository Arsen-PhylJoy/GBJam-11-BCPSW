extends RigidBody2D

signal on_meteor_deleted(meteor)

func _ready() -> void:
	$meteorite_animation.play("meteorite")

func _exit_tree() -> void:
	self.queue_free()

func _process(_delta) -> void:
	$".".rotation = 0.0
	
func _on_body_entered(body: Node) -> void:
	if(body.is_in_group("Ground")):
		emit_signal("on_meteor_deleted", self)
