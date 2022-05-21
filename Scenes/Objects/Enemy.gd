extends KinematicBody2D

var velocity = Vector2.ZERO
var speed = 200
var health = 100
var chase = false
var can_damage = true
export var damage = 15

func _ready():
	pass 

func _physics_process(delta):
	var player = get_tree().get_root().get_node(Globals.level + "/Player").get_node_or_null("Player")
	if chase ==  true:
		velocity = Vector2.ZERO
		if player != null:
			velocity = position.direction_to(player.position) * speed
		velocity = move_and_slide(velocity)
		
	if player in $damageArea.get_overlapping_bodies() and can_damage:
		print(player.health)
		player.health -= damage
		can_damage = false
		$damageTimer.start()
	
	if health <= 0:
		queue_free()


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		print("pede")
		chase = true

func _on_Area2D_body_exited(body):
	if body.name == "Player":
		chase = false


func _on_damageTimer_timeout():
	can_damage = true
