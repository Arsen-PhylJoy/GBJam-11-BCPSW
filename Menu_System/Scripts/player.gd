extends Area2D

@export var speed = 50
@export var idle_tex = preload("res://assets/graphic/characters/hero/sprite_sheets/idle/character_01_idle_sheet.png")
@export var run_right_tex = preload("res://assets/graphic/characters/hero/sprite_sheets/run/character_01_run_right_sheet.png")
@export var run_left_tex = preload("res://assets/graphic/characters/hero/sprite_sheets/run/character_01_run_left_sheet.png")
@export var defeat_tex = preload("res://assets/graphic/characters/hero/sprite_sheets/defeat/character_01_defeat_sheet.png")
var alive = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$hero_animations.play("hero")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	
	if alive:
		if Input.is_action_pressed("dpad_right"):
			$"hero_mesh".texture = run_right_tex
			velocity.x += 1
		elif Input.is_action_pressed("dpad_left"):
			$"hero_mesh".texture = run_left_tex
			velocity.x -= 1
		else:
			$"hero_mesh".texture = idle_tex
		
	velocity = velocity.normalized() * speed
	position += velocity * delta
	

func _on_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Meteorite")):
		alive = false
		$"hero_mesh".texture = defeat_tex
		await get_tree().create_timer(2.0).timeout
		$"hero_mesh".queue_free()
		self.queue_free()
		
		get_tree().quit()
