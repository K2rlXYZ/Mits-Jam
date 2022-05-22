extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_tree().create_timer(2), "timeout")
	if get_tree().root.get_node_or_null("TransitionOut") != null:
		get_tree().root.get_node("TransitionOut").queue_free()
	$AnimationPlayer.play("in")
	
func _physics_process(_delta):
	if $Taxi.player_in_area and get_node_or_null("TransitionOut") != null and !$TransitionOut.is_playing(): #and get_node_or_null("Enemies/Boss") == null:		
		$TransitionOut.play("transOut")

func destroy():
	reparent($TransitionOut, get_tree().root)
	SceneHandler.load_main_menu()
	get_tree().root.move_child(SceneHandler.main_menu,6)
	queue_free()	
	
func reparent(child: Node, new_parent: Node):
	var old_parent = child.get_parent()
	old_parent.remove_child(child)
	new_parent.add_child(child)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
