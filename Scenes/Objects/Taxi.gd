extends StaticBody2D



func _on_EnterArea_body_entered(body):
	if body.name == "Player":
		# Level won!
		SceneHandler.level_complete()
