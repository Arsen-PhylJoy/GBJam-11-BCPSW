extends Area2D

signal picked_up(speed_mul,scale_mul)
signal deleted(pos)

@export var speed_mul: float = 1.6
@export var scale_mul: float = 0.4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.connect("area_entered",self._on_play_enter)

func _on_play_enter(area: Area2D) -> void:
	if(area.is_in_group("Player")):
		emit_signal("picked_up",speed_mul,scale_mul)
		emit_signal("deleted",self.position)
		self.queue_free()

