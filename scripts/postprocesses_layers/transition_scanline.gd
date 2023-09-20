extends CanvasLayer
##Load this node and prompt start_fade_in or start_fade_out
##after animation this node deletes itself

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func start_fade_in() -> void:
	$Fade_In_Out.show()
	var tween = get_tree().create_tween()
	get_tree().paused = true
	$AnimationPlayer.play_backwards("fade_in")
	await get_tree().create_timer(2).timeout
	get_tree().paused = false
	self.queue_free()
	
func start_fade_out() -> void:
	$Fade_In_Out.show()
	var tween = get_tree().create_tween()
	get_tree().paused = true
	$AnimationPlayer.play("fade_in")
	await get_tree().create_timer(2).timeout
	get_tree().paused = false
	self.queue_free()
