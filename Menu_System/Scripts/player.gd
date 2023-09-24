extends Area2D

signal defeated()
signal player_update_position(position)

@export var speed = 100
@export var defeat_tex = preload("res://assets/graphic/characters/hero/sprite_sheets/defeat/character_01_defeat_sheet.png")

func _ready():
	$hero_animations.play("idle")
	self.set_defeat_animation(4)
	
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

func set_defeat_animation(times) -> void:
	var defeat_animation = $hero_animations.get_animation("defeat") as Animation
	defeat_animation.length = float(times * 0.4)
	var track = defeat_animation.add_track(Animation.TYPE_VALUE, 0)
	defeat_animation.track_set_enabled(track, true)
	defeat_animation.track_set_path(track, "hero_mesh:frame")
	for time in range(times):
		for frame in range(4):
			var key = frame + (4 * time)
			var seconds = float(key/10.0) + 0.1
			defeat_animation.track_insert_key(track, seconds, frame)

	var tex_track = defeat_animation.add_track(Animation.TYPE_VALUE, 1)
	defeat_animation.track_set_enabled(tex_track, true)
	defeat_animation.track_set_path(tex_track, "hero_mesh:texture")
	defeat_animation.track_insert_key(tex_track, 0.0, defeat_tex)
	
func _on_picked_up_magnification(speed_mul,scale_mul)->void:
	print("Picked up magnification")
	
func _on_picked_up_miniaturization(speed_mul,scale_mul)->void:
	print("Picked up miniaturization")
	
func _on_picked_up_shield(shield_time)->void:
	print("Picked up shield")
