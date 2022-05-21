extends Area2D

export var fly_speed = 15

var dir = Vector2.ZERO
var dieing = false


func _ready():
	pass
	
func _physics_process(delta):
	position += dir * fly_speed

func shoot(towards):
	$Sprite.rotate(-2)
	dir = (towards - position).normalized()
	
	


func _on_furball_body_entered(body):
	var pl = get_node_or_null("/root/Level1/Player")
	if body.is_in_group("Enemies"):
		body.health-=25
		dieing = true
		destroy()
	elif pl == body:
		pass
	else:
		dieing = true
		destroy()
			
func destroy():
	queue_free()
