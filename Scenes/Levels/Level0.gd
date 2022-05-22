extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var state = 0
var keys_pressed = []
var trans_is_played = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("kt_in")
	
func _physics_process(_delta):
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
				state += 1
					
		1:
			if !$AnimationPlayer.is_playing():
					$AnimationPlayer.play("rs_in")
					state += 1
		2:
			if $Player.weapon != null:
				$AnimationPlayer.play("rs_out")
				state += 1
		3:
			if !$AnimationPlayer.is_playing():
				$AnimationPlayer.play("e_in")
				state += 1
		4:
			if get_node_or_null("Enemy") == null and $Taxi.player_in_area:
				$AnimationPlayer.play("e_out")
				state += 1
		5:
			if get_node_or_null("Enemy") == null and $Taxi.player_in_area and !$AnimationPlayer.is_playing():
				if get_node_or_null("TransitionOut") != null and !$TransitionOut.is_playing() and not trans_is_played:
					trans_is_played = true
					$TransitionOut.play("transOut")
				
	
	
func destroy():
	reparent($TransitionOut, get_tree().root)
	SceneHandler.load_level("Level1")
	queue_free()
	
func reparent(child: Node, new_parent: Node):
	var old_parent = child.get_parent()
	old_parent.remove_child(child)
	new_parent.add_child(child)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	
