extends CanvasLayer
##Load this node and prompt start_fade_in or start_fade_out
##after animation this node deletes itself
signal finished()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process_input(false)
	process_mode = Node.PROCESS_MODE_ALWAYS

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _exit_tree() -> void:
		set_process_input(true)

func start_fade_in() -> void:
	get_tree().paused = true
	$AnimationPlayer.play("fade_in")
	await $AnimationPlayer.animation_finished
	emit_signal("finished")
	get_tree().paused = false
	self.queue_free()
	
func start_fade_out() -> void:
	get_tree().paused = true
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	emit_signal("finished")
	get_tree().paused = false
	self.queue_free()
