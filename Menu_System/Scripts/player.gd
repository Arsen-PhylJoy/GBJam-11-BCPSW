extends Area2D

signal defeated()
signal player_update_position(position)

@export var speed = 100
@export var idle_tex = preload("res://assets/graphic/characters/hero/sprite_sheets/idle/character_01_idle_sheet.png")
@export var run_right_tex = preload("res://assets/graphic/characters/hero/sprite_sheets/run/character_01_run_right_sheet.png")
@export var run_left_tex = preload("res://assets/graphic/characters/hero/sprite_sheets/run/character_01_run_left_sheet.png")
@export var defeat_tex = preload("res://assets/graphic/characters/hero/sprite_sheets/defeat/character_01_defeat_sheet.png")
var alive = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$hero_animations.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	var update_position = false
	var player_run_sfx = $player_sfx as AudioStreamPlayer	
	
	if alive:
		if Input.is_action_pressed("dpad_right"):
			$hero_animations.play("run_right")
			velocity.x += 1
			update_position = true
		elif Input.is_action_pressed("dpad_left"):
			$hero_animations.play("run_left")
			velocity.x -= 1
			update_position = true
		else:
			$hero_animations.play("idle")
			player_run_sfx.stop()
			
	velocity = velocity.normalized() * speed
	position += velocity * delta
	
	if update_position:
		emit_signal("player_update_position", $".".global_position)
		if not player_run_sfx.playing:
			player_run_sfx.play()
	

func _on_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Meteorite")):
		alive = false
		$hero_animations.play("defeat")
		await $hero_animations.animation_finished
		emit_signal("defeated")
