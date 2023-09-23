extends Area2D

signal defeated()
signal player_update_position(position)

@export var speed = 100
@export var defeat_tex = preload("res://assets/graphic/characters/hero/sprite_sheets/defeat/character_01_defeat_sheet.png")

var can_dash = true
var can_move = true

func _ready():
	$hero_animations.play("idle")
	self.set_defeat_animation(4)
	
func _process(delta):
	var velocity = Vector2.ZERO
	var update_position = false
	var player_run_sfx = $player_sfx as AudioStreamPlayer
	
	#var to hold initial speed value 
	var temp_speed = speed
	
	if not Global.isDeafeated:
		if Input.is_action_pressed("dpad_right"):
			$hero_animations.play("run_right")
			velocity.x += 1
			
			#the Dash action
			#after inputing the dash input, internals timers are made that temporatily increase speed
			#and another timer that starts a dash cooldown
			if Input.is_action_just_pressed("a") and can_dash:
				print("pressed Dash button")
				speed = speed * 4
				can_dash = false
				await get_tree().create_timer(0.2).timeout
				speed = temp_speed
				await get_tree().create_timer(0.5).timeout
				can_dash = true
				
			update_position = true
			
			
		elif Input.is_action_pressed("dpad_left"):
			$hero_animations.play("run_left")
			velocity.x -= 1
			
			#the Dash action
			#after inputing the dash input, internals timers are made that temporatily increase speed
			#and another timer that starts a dash cooldown
			if Input.is_action_just_pressed("a") and can_dash:
				print("pressed Dash button")
				speed = speed * 4
				can_dash = false
				await get_tree().create_timer(0.2).timeout
				speed = temp_speed
				await get_tree().create_timer(0.5).timeout
				can_dash = true
			
			update_position = true
		else:
			$hero_animations.play("idle")
			player_run_sfx.stop()
			
	velocity = velocity * speed
	#velocity = velocity.normalized() * speed
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
