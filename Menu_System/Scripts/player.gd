extends Area2D

@export var speed = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("dpad_right"):
		velocity.x += 1
		
	if Input.is_action_pressed("dpad_left"):
		velocity.x -= 1
		
	velocity = velocity.normalized() * speed
	position += velocity * delta
	


func _on_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Meteorite")):
		self.queue_free()
		
