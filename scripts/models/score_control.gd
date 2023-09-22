extends Object

class_name PlayerScoreControl

var player: String
var current_score: int
var display_score: int
var levels: Array[ScoreBlock]

func _init(_player: String, _levels: Array[Global.Level] = []):
	self.player = _player
	self.current_score = -1
	self.display_score = 0
	if len(_levels) > 0:
		self.levels = self._create_levels(_levels)

func _create_levels(_levels: Array[Global.Level]) -> Array[ScoreBlock]:
	var result: Array[ScoreBlock] = []
	for _level in _levels:
		result.push_back(ScoreBlock.new(_level))
	return result

func add_levels(_levels: Array[Global.Level]):
	var levels_to_add = self._create_levels(_levels)
	for level_to_add in levels_to_add:
		var level_exists = false
		for level_block in self.levels:
			if level_block.level == level_to_add.level:
				level_exists = true
		if  not level_exists:
			self.levels.append_array(levels_to_add)
	
func delete_levels(_levels: Array[Global.Level]):
	var tmp: Array[ScoreBlock] = []
	for level_block in self.levels:
		if not _levels.has(level_block.level):
			tmp.push_back(level_block)
	self.levels = tmp
	
func get_score_by_level(_level: Global.Level) -> int:
	var result: int = -1
	for level_block in self.levels:
		if level_block.level == _level:
			result = level_block.score
			break
	return result
	
func set_score_by_level(_level: Global.Level) -> void:
	for level_block in self.levels:
		if level_block.level == _level:
			level_block.score = self.current_score
			break
	
func set_current(score: int):
	self.current_score = score
	
func get_current() -> int:
	return self.current_score
	
class ScoreBlock:
	var score: int
	var level: Global.Level
	
	func _init(_level: Global.Level, _score: int = -1):
		self.level = _level
		self.score = _score
