extends Node2D

signal projectile_spawned(pos,init_speed,gravity_scale)

@export var projectile: PackedScene

@export var spawner_width: float = 100
@export var meteortirs_per_second: float  = 1
##Default is 9.8.
@export var gravity_scale: float = 1

@export_group("random spawning ranges")
@export_subgroup("Initial speed")
@export var min_initial_speed: float = 100
@export var max_initial_speed: float = 200
##[color=red]Doesn't work.[/color].

var rand: RandomNumberGenerator = RandomNumberGenerator.new()

func _ready() -> void:
	randomize()
	$Timer.wait_time = 1/meteortirs_per_second

func _exit_tree() -> void:
	self.queue_free()
	
func _on_timer_timeout() -> void:
	emit_signal("projectile_spawned",
			rand.randf_range(self.global_position.x - spawner_width,spawner_width + self.global_position.x),
			rand.randf_range(min_initial_speed,max_initial_speed),
			gravity_scale)

