extends Node2D

##If power_up_pos_x == 1000
signal power_up_spawn(power_up_index,power_up_pos_x)

@export_category("Spawner properties")
@export var power_ups_amount = 20
@export var min_spacing: int = 80
@export var max_spacing: int = 160
@export_range(0,100) var spawn_chance: int = 20
@export var spawner_width: int = 3000
##minimum distance from the player where Power ups will spawn.
@export var spawning_range: int = 130
@export var try_spawn_power_up_per_second: float = 2

@export var power_ups_pks: Array[PackedScene]
@export var Player: Node2D

#Pools
#"spawners" and "is_spawner_available"  intended to be
#dictionary or 2d array but I didn't have time to master those.
var spawners: Array[Marker2D]
var is_spawner_available: Array[bool]

var rand: RandomNumberGenerator = RandomNumberGenerator.new()

func _ready() -> void:
	#warning-ignore:INTEGER_DIVISION
	#Don't want work with floats because decimal types has precision and integer doesn not.
	var prev_position: float = 0
	for i in power_ups_amount:
		spawners.append(Marker2D.new())
		is_spawner_available.append(true)
		spawners[i].position.x = rand.randi_range(min_spacing,max_spacing) + prev_position
		prev_position = spawners[i].position.x
		
	randomize()
	$Timer.wait_time = 1/try_spawn_power_up_per_second
	$Timer.connect("timeout",self._on_try_spawn_power_up)
	
func detect_empty_position(player_pos_x: float)->float:
	#-1000 return code correspond to "no space in space"(joke), just no space to place power up
	var avaiable_position_x: float = -1000
	for i in spawners.size():
		if(is_spawner_available[i] == true && player_pos_x+spawning_range<spawners[i].position.x):
			is_spawner_available[i] = false;
			return spawners[i].position.x
	return avaiable_position_x;
	
func _on_try_spawn_power_up()->void:
	var power_up_pos_x: float = 0
	if((rand.randi()%100)<spawn_chance):
		return;
	power_up_pos_x = detect_empty_position(Player.global_position.x)
	if(power_up_pos_x == -1000):
		return;
	var power_up_index: int = randi_range(0,2)
	emit_signal("power_up_spawn",power_up_index,power_up_pos_x)
	
func _on_power_up_deleted(pos: Vector2)->void:
	for i in spawners.size():
		if(spawners[i].position.x == pos.x):
			is_spawner_available[i] = true
	
