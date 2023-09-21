extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var free_timer: Timer = Timer.new()
	add_child(free_timer)
	free_timer.start(16)
	free_timer.connect("timeout",self.queue_free)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
