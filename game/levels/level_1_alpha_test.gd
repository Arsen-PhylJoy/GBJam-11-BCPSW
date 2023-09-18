extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_projectile_spawner_projectile_spawned(pos, new_scale, init_speed, angular_velocity, direction_vector, gravity_scale) -> void:
	var meteor_instance: RigidBody2D =  $projectile_spawner.projectile.instantiate() as RigidBody2D
	add_child(meteor_instance)
	meteor_instance.global_position.x = pos
	meteor_instance.global_scale = Vector2(new_scale,new_scale)
	meteor_instance.linear_velocity = init_speed * direction_vector
	meteor_instance.angular_velocity = angular_velocity
	meteor_instance.gravity_scale = gravity_scale
