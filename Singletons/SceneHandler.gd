extends Node



var levels = ["Level1", "Level2", "Level3", "Level4"]
var current_level = null
var current_level_name = null
var pause_screen_loaded = false
var pause_screen


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
		
func load_main_menu():
	var main_menu = load("res://Scenes/UI/MainMenu.tscn").instance()
	get_tree().root.add_child(main_menu)
		
func load_death_screen():
	var death_screen = load("res://Scenes/UI/DeathScreen.tscn").instance()
	get_tree().get_root().add_child(death_screen)
	
func load_pause_screen():
	if (pause_screen_loaded):
		pause_screen.get_parent().remove_child(pause_screen)
		pause_screen_loaded = false
		get_tree().paused = false
	else:
		pause_screen = load("res://Scenes/UI/PauseScreen.tscn").instance()
		get_tree().root.add_child(pause_screen)
		pause_screen_loaded = true
		get_tree().paused = true

func restart_level():
	current_level.queue_free()
	load_level(current_level_name)
	
