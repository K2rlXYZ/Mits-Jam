extends KinematicBody2D

var velocity = Vector2.ZERO
var speed = 200

func _ready():
	pass 

func _physics_process(delta):
	velocity = Vector2.ZERO
	var player = get_parent().get_node_or_null("Player")
	if player != null:
		velocity = position.direction_to(player.position) * speed
	velocity = move_and_slide(velocity)
