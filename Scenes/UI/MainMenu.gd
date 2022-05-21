extends Control


func _ready():
	for button in get_node("M/VB").get_children():
		button.text = button.name
		button.connect("pressed", self, "load_" + button.name)


func load_level(lvl):
	SceneHandler.load_level(lvl)
	
	queue_free()


func load_Level1():
	load_level("Level1")

func load_Level2():
	load_level("Level2")

func load_Level3():
	load_level("Level3")

func load_Level4():
	load_level("Level4")

func load_Level0():
	load_level("Level0")

func load_Level5():
	load_level("Level5")
