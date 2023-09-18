extends RigidBody2D

func _exit_tree() -> void:
	self.queue_free()
