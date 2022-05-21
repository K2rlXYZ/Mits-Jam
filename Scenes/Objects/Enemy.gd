extends KinematicBody2D

var velocity = Vector2.ZERO
var speed = 200
var health = 100
var chase = false

func _ready():
	pass 

func _physics_process(delta):
	if chase ==  true:
		velocity = Vector2.ZERO
		var player = get_parent().get_parent().get_node_or_null("Player")
		if player != null:
			velocity = position.direction_to(player.position) * speed
		velocity = move_and_slide(velocity)
		
	
	
	if health <= 0:
		queue_free()


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		print("pede")
		chase = true

func _on_Area2D_body_exited(body):
	if body.name == "Player":
		chase = false
