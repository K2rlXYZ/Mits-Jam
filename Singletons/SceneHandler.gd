extends Node



var levels = ["Level0", "Level1", "Level2", "Level3", "Level4", "Level5"]
var current_level = null
var current_level_name = null
var pause_screen_loaded = false
var pause_screen
var last_loaded = "main_menu"

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS


"""func _physics_process(delta):
	match current_level_name:
		"Level1":
			all_enemies_dead(current_level)
		"Level2":
			# taxi level
			pass
		"Level3":
			all_enemies_dead(current_level)
		"Level4":
			all_enemies_dead(current_level)

func all_enemies_dead(level):
	if level.get_node("Enemies").get_children().empty():
		level_complete()"""




func load_level(lvl):
	# Load new level
	Globals.level = lvl
	current_level_name = lvl
	var level = load("res://Scenes/Levels/" + lvl + ".tscn").instance()
	current_level = level
	
	get_tree().get_root().call_deferred("add_child", level, true)

func level_complete():
	var lvl = levels.find(current_level_name)
	if lvl < levels.size():
		load_level(levels[lvl+1])
		
func load_main_menu_old():
	var main_menu_old = load("res://Scenes/UI/MainMenu.tscn").instance()
	last_loaded = "main_menu_old"
	get_tree().root.add_child(main_menu_old)
	
func load_main_menu():
	last_loaded = "main_menu"
	var main_menu = load("res://Scenes/UI/MainMenuRedo.tscn").instance()
	get_tree().root.add_child(main_menu)
	
func load_settings_screen():
	var settings_screen = load("res://Scenes/UI/Settings.tscn").instance()
	get_tree().root.add_child(settings_screen)
		
func load_death_screen():
	var death_screen = load("res://Scenes/UI/DeathScreen.tscn").instance()
	last_loaded = "death_screen"
	get_tree().get_root().add_child(death_screen)
	
func load_pause_screen():
	if (pause_screen_loaded):
		pause_screen.queue_free()
		pause_screen_loaded = false
		get_tree().paused = false
	else:
		pause_screen = load("res://Scenes/UI/PauseScreen.tscn").instance()
		last_loaded = "pause_screen"
		get_tree().root.add_child(pause_screen)
		pause_screen_loaded = true
		get_tree().paused = true

func restart_level():
	current_level.queue_free()
	load_level(current_level_name)
	
