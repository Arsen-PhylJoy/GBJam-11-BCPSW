extends Node

signal exit_game

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_PAUSABLE
	
	get_node("Pause Screen").hide()
	
	get_node("Pause Screen/Resume Button").pressed.connect(self.on_resume_button_pressed)
	
	get_node("Pause Screen/Exit Button").pressed.connect(self.on_exit_button_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $"Pause Timer".is_stopped() == true:
		if Input.is_action_pressed("pause"):
			print("P pressed during unpaused")
			on_pause_button_pressed()
	pass


func _on_projectile_spawner_projectile_spawned(pos, new_scale, init_speed, angular_velocity, direction_vector, gravity_scale) -> void:
	var meteor_instance: RigidBody2D =  $Player/projectile_spawner.projectile.instantiate() as RigidBody2D
	add_child(meteor_instance)
	meteor_instance.global_position.x = pos
	meteor_instance.global_scale = Vector2(new_scale,new_scale)
	meteor_instance.linear_velocity = init_speed * direction_vector
	meteor_instance.angular_velocity = angular_velocity
	meteor_instance.gravity_scale = gravity_scale
	

func on_pause_button_pressed() -> void:
	get_tree().paused = true
	$"Pause Screen".show()
	$"Pause Screen/PauseTimer".start()
	$"Pause Screen/Resume Button".grab_focus()
	
func on_resume_button_pressed() -> void:
	$"Pause Screen".hide()
	get_tree().paused = false

func on_exit_button_pressed() -> void:
	print("Pressed exit button")
	get_tree().paused = false
	emit_signal("exit_game")

func _on_pause_screen_unpause() -> void:
	print("unpaused by pressing pause button")
	$"Pause Timer".start()
	
