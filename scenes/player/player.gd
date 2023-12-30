extends Area2D

signal defeated()
signal player_update_position(position)
signal on_meteor_deleted(meteor)

@export var dash_offset = 0.1
@export var dash_cooldown = 1.5
@export var dash_speed = 400
@export var speed = 100
@export var defeat_tex = preload("res://assets/graphic/characters/hero/sprite_sheets/defeat/character_01_defeat_sheet.png")

var active_speed = speed
var power_up: PowerUp = null
var power_up_stash: PowerUp = null
var counter = 0.0
var delta_deadend = 0
var isDashing = false
var isMortal = true
var dash_timer: Timer

func _ready():
	self.dash_timer = $hero_mesh/dash_timer
	self.dash_timer.wait_time = dash_cooldown
	$hero_animations.play("idle")
	self.set_defeat_animation(4)

func _process(delta):
	var power_up_context = null
	if self.power_up != null and self.power_up.active:
		if self.power_up.type != Global.PowerUp.SHIELD:
			power_up_context = self.power_up.type
		
		
	if counter > 1000.0:
		counter = 0.0
	counter += delta
	self.active_speed = speed
	var velocity = Vector2.ZERO
	var update_position = false
	var player_run_sfx = $player_sfx as AudioStreamPlayer
	_power_up_handler()
	_dash_handler()
	
	if not Global.isDeafeated:
		if Input.is_action_pressed("dpad_right"):
			if power_up_context == Global.PowerUp.BIG:
				$hero_animations.play("run_right_BIG")
			elif power_up_context == Global.PowerUp.SMALL:
				$hero_animations.play("run_right_SMALL")
			elif power_up_context == null:
				$hero_animations.play("run_right")
				
			velocity.x += 1
			update_position = true
		elif Input.is_action_pressed("dpad_left"):
			if power_up_context == Global.PowerUp.BIG:
				$hero_animations.play("run_left_BIG")
			elif power_up_context == Global.PowerUp.SMALL:
				$hero_animations.play("run_left_SMALL")
			elif power_up_context == null:
				$hero_animations.play("run_left")
			
			velocity.x -= 1
			update_position = true
		else:
			if power_up_context == Global.PowerUp.BIG:
				$hero_animations.play("idle_BIG")
			elif power_up_context == Global.PowerUp.SMALL:
				$hero_animations.play("idle_SMALL")
			elif power_up_context == null:
				$hero_animations.play("idle")
				
			player_run_sfx.stop()
#			isDashing = false
			
	velocity = velocity.normalized() * self.active_speed
	position += velocity * delta
	
	if update_position:
		emit_signal("player_update_position", $".".global_position)
		if not player_run_sfx.playing:
			player_run_sfx.play()
	if Input.is_action_just_pressed("dpad_down"):
		swap_power_ups()
		
func _on_body_entered(body: Node2D) -> void:
	if not Global.isDeafeated and body.is_in_group("Meteorite"):
		$meteorite_collision.play()
		emit_signal("on_meteor_deleted", body)
		if isMortal:
			Global.isDeafeated = true
			$hero_animations.play("defeat")
			$death.play()
			await $hero_animations.animation_finished
			emit_signal("defeated")
		else:
			self.power_up.charge -= 1
			

func _dash_handler()-> void:
	if power_up == null or not power_up.active:
		if isDashing and counter >= delta_deadend:
			self.active_speed = speed 
			isDashing = false
		elif isDashing and counter < delta_deadend:
			self.active_speed = dash_speed
		elif Input.is_action_just_pressed("a") and not isDashing and dash_timer.is_stopped():
			dash_timer.start()
			self.active_speed = dash_speed
			isDashing = true
			delta_deadend = counter + dash_offset

func _power_up_handler()-> void:
	if not isDashing and power_up != null:
		if power_up.active:
			if power_up.hasTimer:
				if counter >= power_up.destroy_time:
					self.active_speed = speed
					isMortal = true
					get_stashed_power_up()
				elif counter < power_up.destroy_time:
					self.active_speed = speed * power_up.speed_factor
					isMortal = !power_up.immortality
			else:
				if isMortal and power_up.charge > 0:
					isMortal = false
				elif power_up.charge <= 0:
					$shield_down.play()
					isMortal = true
					get_stashed_power_up()
		elif Input.is_action_just_pressed("b"):
			power_up.activate_power(counter)
			if(power_up.type == Global.PowerUp.BIG):
				$big_power_up_use.play()
			elif(power_up.type == Global.PowerUp.SMALL):
				$small_power_up_use.play()
			else:
				$shield_up.play()

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
	
func _on_picked_up_magnification()->void:
	$power_up_picked_up.play()
	var _power_up = PowerUp.new(Global.PowerUp.BIG, 5.0)
	set_stashed_power_up(_power_up)	
	
func _on_picked_up_miniaturization()->void:
	$power_up_picked_up.play()
	var _power_up = PowerUp.new(Global.PowerUp.SMALL, 2.0)
	set_stashed_power_up(_power_up)
	
func _on_picked_up_shield()->void:
	$power_up_picked_up.play()
	var _power_up = PowerUp.new(Global.PowerUp.SHIELD, 2.0)
	set_stashed_power_up(_power_up)

func get_stashed_power_up():
	if self.power_up_stash != null:
		self.power_up = self.power_up_stash
		self.power_up_stash = null
	else:
		self.power_up = null
		
func set_stashed_power_up(_power_up):
	if self.power_up == null:
		self.power_up = _power_up
	else:
		self.power_up_stash = _power_up
		
func swap_power_ups()->void:
	if self.power_up != null and self.power_up_stash != null and not self.power_up.active:
		var tmp: PowerUp = self.power_up
		self.power_up = self.power_up_stash
		self.power_up_stash = tmp
		
class PowerUp:
	var active: bool = false
	var type: Global.PowerUp
	var hasTimer: bool = true
	var destroy_time: float
	var charge: float = 0
	var speed_factor: float = 1.0
	var scale_factor: float = 1.0
	var immortality: bool = false
	
	func _init(_type: Global.PowerUp, _charge: float = 1.0):
		self.type = _type
		self.charge = _charge
		if _type == Global.PowerUp.BIG:
			self.speed_factor = 0.5
			self.scale_factor = 2.25
			self.immortality = true
		elif _type == Global.PowerUp.SMALL:
			self.speed_factor = 2
			self.scale_factor = 0.75
		elif _type == Global.PowerUp.SHIELD:
			self.hasTimer = false
			self.immortality = true
			
	func activate_power(_counter):
		self.active = true
		if not self.type == Global.PowerUp.SHIELD:
			self.destroy_time = _counter + self.charge
		# PLAY TRANSFORM ANIMATION

