extends Area2D

export var fly_speed = 15

var dir = Vector2.ZERO
var dieing = false


func _ready():
	pass
	
func _physics_process(_delta):
	position += dir * fly_speed

func shoot(towards):
	$Sprite.rotate(-2)
	dir = (towards - position).normalized()
	
	
func _on_Ketamine_body_entered(body):
	if body.is_in_group("Enemies"):
		body.health-=25
		dieing = true
		destroy()
	else:
		dieing = true
		destroy()

			
func destroy():
	queue_free()
