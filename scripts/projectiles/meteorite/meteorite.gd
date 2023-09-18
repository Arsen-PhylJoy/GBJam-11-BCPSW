extends RigidBody2D

func _exit_tree() -> void:
	self.queue_free()



func _on_body_entered(body: Node) -> void:
	if(body.is_in_group("Ground")):
		self.queue_free()


