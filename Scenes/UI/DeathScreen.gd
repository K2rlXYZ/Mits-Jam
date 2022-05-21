extends Control




func _on_Retry_pressed():
	SceneHandler.restart_level()
	queue_free()



func _on_MainMenu_pressed():
	SceneHandler.load_mainmenu()
	queue_free()
