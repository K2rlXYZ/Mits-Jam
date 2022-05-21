extends Node



var levels = ["Level1", "Level2", "Level3", "Level4"]
var current_level = null
var current_level_name = null


func load_level(lvl):
	# Load new level
	Globals.level = lvl
	current_level_name = lvl
	var level = load("res://Scenes/Levels/" + lvl + ".tscn").instance()
	current_level = level
	
	get_tree().get_root().call_deferred("add_child", level, true)

func level_complete():
	current_level.queue_free()
	var lvl = levels.find(current_level_name)
	if lvl < levels.size():
		load_level(levels[lvl+1])
