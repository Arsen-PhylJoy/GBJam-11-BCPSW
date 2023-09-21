extends Node

signal exit_game
signal defeat

var meteorite_pool: Array[MeteoriteBlock] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_PAUSABLE
	get_node("Pause Screen").position.y -= 30
	get_node("Pause Screen").hide()
	get_node("Pause Screen/Resume Button").pressed.connect(self.on_resume_button_pressed)
	get_node("Pause Screen/Exit Button").pressed.connect(self.on_exit_button_pressed)
	
	$Player.connect("defeated", self._on_defeat)
	$Player.connect("player_update_position", self._on_player_move)
	
	var projectile_node = $Player/projectile_spawner
	projectile_node.position.x = 0
	projectile_node.position.y = 0
	projectile_node.connect("projectile_spawned", self._on_projectile_spawner_projectile_spawned)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(_delta: float) -> void:
	if $"Pause Timer".is_stopped() == true:
		if Input.is_action_pressed("pause"):
			print("P pressed during unpaused")
			on_pause_button_pressed()
	
	#Pause screen follows player to that it's always in the screen when the player pauses
	#80 is the offset so that it stays in the center (half of 160, the screen size)
	get_node("Pause Screen").position.x = get_node("Player").position.x - 80


func _on_projectile_spawner_projectile_spawned(pos, new_scale, init_speed, angular_velocity, direction_vector, gravity_scale) -> void:
	var meteor_instance: RigidBody2D =  $Player/projectile_spawner.projectile.instantiate() as RigidBody2D
	add_child(meteor_instance)
	meteor_instance.global_position.x = pos
	meteorite_pool.append(MeteoriteBlock.new(meteor_instance, pos))
	meteor_instance.global_scale = Vector2(new_scale,new_scale)
	meteor_instance.linear_velocity = init_speed * direction_vector
	meteor_instance.angular_velocity = angular_velocity
	meteor_instance.gravity_scale = gravity_scale
	meteor_instance.connect("on_meteor_deleted", self._on_meteor_deleted)
	
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
	
func _on_defeat() -> void:
	await get_tree().create_timer(2.0).timeout
	emit_signal("defeat")
	
func _on_player_move(_position) -> void:
	var offset = (160/2)*1.05
	var to_delete: Array[MeteoriteBlock] = []
	var to_preserve: Array[MeteoriteBlock] = []
	for met in meteorite_pool:
		if (met.offset > _position.x + offset) or (met.offset < _position.x - offset):
			to_delete.push_back(met)
		else:
			to_preserve.push_back(met)
	for met in to_delete:
		if met.meteorite:
			met.meteorite.queue_free()
	meteorite_pool = to_preserve
		
func _on_meteor_deleted(meteor):
	meteorite_pool.erase(meteor)
	meteor.queue_free()
	
class MeteoriteBlock:
	var meteorite: RigidBody2D
	var offset: int
	func _init(meteorite: RigidBody2D, offset: int):
		self.meteorite = meteorite
		self.offset = offset
