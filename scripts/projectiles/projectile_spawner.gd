extends Node2D

signal projectile_spawned(pos,new_scale,init_speed,angular_velocity,direction_vector,gravity_scale)

@export var projectile: PackedScene
@export var spawner_width: float = 100
@export var meteortirs_per_second: float  = 1
##Default is 9.8.
@export var gravity_scale: float = 1

@export_group("random spawning ranges")
@export_subgroup("Initial speed")
@export var min_initial_speed: float = 100
@export var max_initial_speed: float = 200
@export_subgroup("Angular velocity")
##In degrees per second.
@export var min_angular_velocity: float = 10
##In degrees per secon.
@export var max_angular_velocity: float = 20
@export_subgroup("scale")
@export var min_scale: float = 1
@export var max_scale: float = 1
@export_subgroup("Direction vector")
##Deviation from the default direction vector in degrees. Default direction vector is (0,1) pointing down.
@export_range(0,90) var left_deviation: float = 0
@export_range(0,90) var right_deviation: float = 0

var rand: RandomNumberGenerator = RandomNumberGenerator.new()

func _ready() -> void:
	randomize()
	$Timer.wait_time = 1/meteortirs_per_second

func _exit_tree() -> void:
	self.queue_free()
	
func _on_timer_timeout() -> void:
	var angle:float = deg_to_rad(rand.randf_range(left_deviation,right_deviation))
	emit_signal("projectile_spawned",
			rand.randf_range(0,spawner_width),
			rand.randf_range(min_scale,max_scale),
			rand.randf_range(min_initial_speed,max_initial_speed),
			rand.randf_range(min_angular_velocity,max_angular_velocity),
			Vector2(sin(deg_to_rad(angle)),cos(deg_to_rad(angle))),
			gravity_scale)


##Draws a line along which projectiles will spawn
func _draw() -> void:
	draw_line(self.global_position, Vector2(spawner_width, self.global_position.y), Color(255, 0, 0), 1)

