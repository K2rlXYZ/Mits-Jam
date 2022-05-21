extends CanvasLayer


func _ready():
	pass # Replace with function body.



func _on_QuitButton_pressed():
	get_tree().quit()


func _on_SettingsButton_pressed():
	SceneHandler.load_settings_screen()
	queue_free()


func _on_PlayButton_pressed():
	SceneHandler.load_level("Level1")
	queue_free()


func _on_HAXBUTTONNOB_pressed():
	SceneHandler.load_main_menu_old()
	queue_free()