extends Node2D

signal projectile_spawned(pos,init_speed,gravity_scale)

@export var projectile: PackedScene

var spawner_width: float = 100
var meteortirs_per_second: float  = 1
##Default is 9.8.
var gravity_scale: float = 0.004
var min_initial_speed: float = 10
var max_initial_speed: float = 30

@export var speed_of_fast_prjectile: float = 100;
var chance_to_spawn_fast_projectile:int = 0

@export_category("difficulty threshholds")
@export_group("init difficulty")
@export var meteortirs_per_second_0 = 1
@export var min_initial_speed_0: float = 10
@export var max_initial_speed_0: float = 30
@export_range(0,100) var chance_to_spawn_fast_projectile_0: int = 5
@export_group("1 difficulty")
@export var meteortirs_per_second_1 = 1
@export var min_initial_speed_1: float = 10
@export var max_initial_speed_1: float = 30
@export_range(0,100) var chance_to_spawn_fast_projectile_1: int = 15
@export_group("2 difficulty")
@export var meteortirs_per_second_2 = 1
@export var min_initial_speed_2: float = 10
@export var max_initial_speed_2: float = 30
@export_range(0,100) var chance_to_spawn_fast_projectile_2: int = 20
@export_group("3 difficulty")
@export var meteortirs_per_second_3 = 1
@export var min_initial_speed_3: float = 10
@export var max_initial_speed_3: float = 30
@export_range(0,100) var chance_to_spawn_fast_projectile_3: int = 15
@export_group("4 difficulty")
@export var meteortirs_per_second_4 = 1
@export var min_initial_speed_4: float = 10
@export var max_initial_speed_4: float = 30
@export_range(0,100) var chance_to_spawn_fast_projectile_4: int = 10

static var prev_level_of_difficulty: int = 0

var rand: RandomNumberGenerator = RandomNumberGenerator.new()

func _ready() -> void:
	randomize()
	#set up initial difficulty here
	meteortirs_per_second = meteortirs_per_second_0
	min_initial_speed = min_initial_speed_0
	max_initial_speed = max_initial_speed_0
	chance_to_spawn_fast_projectile = chance_to_spawn_fast_projectile_0
	
func _process(_delta) -> void:
	pass
	
func _physics_process(_delta: float) -> void:
	$Timer.wait_time = 1/meteortirs_per_second

func _exit_tree() -> void:
	self.queue_free()
	
func _on_timer_timeout() -> void:
	var speed: float = 0
	if(rand.randi_range(0,100)<chance_to_spawn_fast_projectile):
		speed = speed_of_fast_prjectile
	else:
		speed = rand.randf_range(min_initial_speed,max_initial_speed)
	emit_signal("projectile_spawned",
			rand.randf_range(self.global_position.x - spawner_width,spawner_width + self.global_position.x),
			speed,
			gravity_scale)

func set_difficulty_level(level: int)->void:
	if(level == 1 && prev_level_of_difficulty<=level):
		prev_level_of_difficulty = 1
		meteortirs_per_second = meteortirs_per_second_1
		min_initial_speed = min_initial_speed_1
		max_initial_speed = max_initial_speed_1
		chance_to_spawn_fast_projectile = chance_to_spawn_fast_projectile_1
	elif(level == 2 && prev_level_of_difficulty<=level):
		prev_level_of_difficulty = 2
		meteortirs_per_second = meteortirs_per_second_2
		min_initial_speed = min_initial_speed_2
		max_initial_speed = max_initial_speed_2
		chance_to_spawn_fast_projectile = chance_to_spawn_fast_projectile_2
	elif(level == 3 && prev_level_of_difficulty<=level):
		prev_level_of_difficulty = 3
		meteortirs_per_second = meteortirs_per_second_3
		min_initial_speed = min_initial_speed_3
		max_initial_speed = max_initial_speed_3
		chance_to_spawn_fast_projectile = chance_to_spawn_fast_projectile_3
	elif(level == 4 && prev_level_of_difficulty<=level):
		prev_level_of_difficulty = 4
		meteortirs_per_second = meteortirs_per_second_4
		min_initial_speed = min_initial_speed_4
		max_initial_speed = max_initial_speed_4
		chance_to_spawn_fast_projectile = chance_to_spawn_fast_projectile_4
