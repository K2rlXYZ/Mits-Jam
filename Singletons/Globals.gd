extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var level
var weapon_range = 150
var opening_played = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _input(event):
	if event.is_action_pressed("toggle_fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
