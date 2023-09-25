extends Node

signal score_update
signal level_score_update
signal finished()

var transition_pk: PackedScene = preload("res://scenes/postprocesses_layers/transitions/transition_scanline.tscn")

var score: PlayerScoreControl
var isDeafeated = false

func init_score_data() -> void:
	score = PlayerScoreControl.new("player_one")

func print_score_data() -> void:
	print("player: " + score.player)
	print("current_score: " + str(score.current_score))
	print("display_score: " + str(score.display_score))
	print("level: " + LevelName[score.levels[0].level])
	print("level_score: " + str(score.levels[0].score))

func update_score_by_move(_score: int) -> void:
	if self.score.current_score < _score:
		self.score.set_current(_score)
		emit_signal("score_update", str(_score))

func emit_current_score() -> void:
	var _current_score = 0
	if (self.score.current_score > 0):
		_current_score = self.score.current_score
	emit_signal("score_update", str(_current_score))

func emit_level_score(_level: Global.Level) -> void:
	var _level_score = self.score.get_score_by_level(_level)
	if (_level_score > 0):
		emit_signal("level_score_update", str(_level_score))

func reset_current_level_score() -> void:
	self.score.set_score_by_level(self.score.current_level.level, false, 0)
	self.score.set_current_level(null)
	self.score.current_score = 0

##If true->fade in else fade out
func fade(fade_flag: bool):
	var transition_screen = transition_pk.instantiate()
	add_child(transition_screen)

	if(fade_flag):
		await transition_screen.start_fade_in()
	else:
		await transition_screen.start_fade_out()
		
	emit_signal("finished")
	return finished

enum Scene {
	INTRO,
	MAIN_MENU,
	LEVEL_1
}

var SceneName = {
	Scene.INTRO: "intro",
	Scene.MAIN_MENU: "main_menu",
	Scene.LEVEL_1: "level_1",
}

enum Layer {
	UI,
	OVER,
	FOREGROUND,
	BACKGROUND,
}

var LayerName = {
	Layer.UI: "UI",
	Layer.OVER: "OVER",
	Layer.FOREGROUND: "FOREGROUND",
	Layer.BACKGROUND: "BACKGROUND",
}

enum Type {
	MENU,
	LEVEL,
	ANIMATION,
}

var TypeName = {
	Type.MENU: "MENU",
	Type.LEVEL: "LEVEL",
	Type.ANIMATION: "ANIMATION"
}

enum Level {
	LEVEL_1
}

var LevelName = {
	Level.LEVEL_1: "LEVEL_1",
}

enum PowerUp {
	BIG,
	SMALL,
	SHIELD
}

var PowerUpName = {
	PowerUp.BIG: "BIG",
	PowerUp.SMALL: "SMALL",
	PowerUp.SHIELD: "SHIELD"
}
