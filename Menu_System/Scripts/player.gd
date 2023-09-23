extends Area2D

signal defeated()
signal player_update_position(position)

@export var speed = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	$hero_animations.play("idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	var update_position = false
	var player_run_sfx = $player_sfx as AudioStreamPlayer	
	
	if not Global.isDeafeated:
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
	if not Global.isDeafeated and body.is_in_group("Meteorite"):
		Global.isDeafeated = true
		$hero_animations.play("defeat")
		await $hero_animations.animation_finished
		emit_signal("defeated")
