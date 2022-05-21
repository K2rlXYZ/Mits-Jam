extends Control




func _on_Retry_pressed():
	SceneHandler.restart_level()
	get_parent().queue_free()



func _on_MainMenu_pressed():
	SceneHandler.current_level_name = null
	SceneHandler.load_main_menu()
	SceneHandler.current_level.queue_free()
	get_parent().queue_free()
