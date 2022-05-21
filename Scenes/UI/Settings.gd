extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var masterBus = AudioServer.get_bus_index("Master")
onready var soundFXBus = AudioServer.get_bus_index("SoundFX")
onready var musicBus = AudioServer.get_bus_index("Music")


# Called when the node enters the scene tree for the first time.
func _ready():
	$Settings/Master/MasterSlider.value = db2linear(AudioServer.get_bus_volume_db(masterBus))
	$Settings/SoundFX/SoundFXSlider.value = db2linear(AudioServer.get_bus_volume_db(soundFXBus))
	$Settings/Music/MusicSlider.value = db2linear(AudioServer.get_bus_volume_db(musicBus))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_MasterSlider_value_changed(value):
	AudioServer.set_bus_volume_db(masterBus, linear2db(value))
	
func _on_SoundFXSlider_value_changed(value):
	AudioServer.set_bus_volume_db(soundFXBus, linear2db(value))

func _on_MusicSlider_value_changed(value):
	AudioServer.set_bus_volume_db(musicBus, linear2db(value))

func _on_BackButton_pressed():
	print(SceneHandler.last_loaded)
	if SceneHandler.last_loaded == "main_menu":
		SceneHandler.load_main_menu()
		queue_free()
	elif SceneHandler.last_loaded == "pause_screen":
		get_tree().paused = false
		SceneHandler.load_pause_screen()
		get_tree().paused = true
		queue_free()
		



