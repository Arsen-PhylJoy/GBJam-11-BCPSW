extends Node2D

signal projectile_spawned(pos,init_speed,gravity_scale)

@export var projectile: PackedScene

@export var spawner_width: float = 100
@export var meteortirs_per_second: float  = 1
##Default is 9.8.
@export var gravity_scale: float = 0.002

@export_group("random spawning ranges")
@export_subgroup("Initial speed")
@export var min_initial_speed: float = 10
@export var max_initial_speed: float = 30
##[color=red]Doesn't work.[/color].

static var prev_level_of_difficulty: int = 0

var rand: RandomNumberGenerator = RandomNumberGenerator.new()

func _ready() -> void:
	randomize()

func _physics_process(_delta: float) -> void:
	$Timer.wait_time = 1/meteortirs_per_second

func _exit_tree() -> void:
	self.queue_free()
	
func _on_timer_timeout() -> void:
	emit_signal("projectile_spawned",
			rand.randf_range(self.global_position.x - spawner_width,spawner_width + self.global_position.x),
			rand.randf_range(min_initial_speed,max_initial_speed),
			gravity_scale)

func set_difficulty_level(level: int)->void:
	if(level == 1 && prev_level_of_difficulty<=level):
		prev_level_of_difficulty = 1;
		meteortirs_per_second = 2.5;
		min_initial_speed = 20;
		max_initial_speed = 30;
	elif(level == 2 && prev_level_of_difficulty<=level):
		prev_level_of_difficulty = 2;
		meteortirs_per_second = 4;
		min_initial_speed = 20;
		max_initial_speed = 30;
	elif(level == 3 && prev_level_of_difficulty<=level):
		prev_level_of_difficulty = 3;
		meteortirs_per_second = 8;
		min_initial_speed = 20;
		max_initial_speed = 30;
	elif(level == 4 && prev_level_of_difficulty<=level):
		prev_level_of_difficulty = 4;
		meteortirs_per_second = 24;
		min_initial_speed = 20;
		max_initial_speed = 30;
