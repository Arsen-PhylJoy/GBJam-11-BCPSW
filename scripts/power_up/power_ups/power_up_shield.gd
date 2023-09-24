extends Area2D

signal picked_up_shield(shield_time)
signal deleted(pos)

@export var shield_time: float = 10.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.connect("area_entered",self._on_play_enter)

func _on_play_enter(area: Area2D) -> void:
	if(area.is_in_group("Player")):
		emit_signal("picked_up_shield",shield_time)
		emit_signal("deleted",self.position)
		self.queue_free()

