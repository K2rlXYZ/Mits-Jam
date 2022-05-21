extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	if event.is_action_pressed("pause"):
		queue_free()
		get_tree().paused = false


func _on_Main_Menu_pressed():
	SceneHandler.current_level.queue_free()
	SceneHandler.load_main_menu()
	queue_free()
	get_tree().paused = false


func _on_Settings_pressed():
	get_tree().paused = false


func _on_ResumeButton_pressed():
	queue_free()
	get_tree().paused = false
