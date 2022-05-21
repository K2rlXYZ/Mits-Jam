extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var state = 0
var keys_pressed = []
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("kt_in")
	
func _process(delta):
	match state:
		0:
			if Input.is_action_pressed("move_left") and not "a" in keys_pressed:
				keys_pressed.append("a")
			if Input.is_action_pressed("move_right") and not "d" in keys_pressed:
				keys_pressed.append("d")
			if Input.is_action_pressed("move_up") and not "w" in keys_pressed:
				keys_pressed.append("w")
			if Input.is_action_pressed("move_down") and not "s" in keys_pressed:
				keys_pressed.append("s")
			
			if keys_pressed.size() == 4:
				$AnimationPlayer.play("kt_out")
				if !$AnimationPlayer.is_playing():
					state += 1
		1:
			if $Player.weapon != null:
				
		2:
			pass
	
	
	
		
	if 
	if keys_pressed.size() == 4 and not keys_played:
		print($AnimationPlayer.current_animation)
		$AnimationPlayer.play("out") 
		if not $AnimationPlayer.is_playing():
			$MessageScreen/Control/MarginContainer/VBoxContainer/HBoxContainer/Label.text = "Move to road and press E to pick up roadsign"
			$AnimationPlayer.play("in")
			keys_played = true
			
	
	
		
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AnimationPlayer_animation_finished(anim_name):
	pass # Replace with function body.
