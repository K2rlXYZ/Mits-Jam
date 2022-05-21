extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Main_Menu_pressed():
	get_tree().root.remove_child(SceneHandler.current_level)
	var main_menu = load("res://Scenes/UI/MainMenu.tscn").instance()
	get_tree().root.add_child(main_menu)
	queue_free()


func _on_Settings_pressed():
	pass # Replace with function body.


func _on_ResumeButton_pressed():
	pass # Replace with function body.
