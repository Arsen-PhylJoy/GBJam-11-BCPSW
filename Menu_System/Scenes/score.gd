extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.connect("score_update", self._on_score_update)
	Global.connect("level_score_update", self._on_level_score_update)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_score_update(text: String):
	$score_display.text = text

func _on_level_score_update(text: String):
	$level_score_display.text = text
