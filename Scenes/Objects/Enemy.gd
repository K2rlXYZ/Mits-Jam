extends KinematicBody2D

var velocity = Vector2.ZERO
var speed = 200
var maxhealth = 100
var health = maxhealth
var chase = false
var can_damage = true
export var damage = 15

func _ready():
	pass 

func _physics_process(_delta):
	var player = SceneHandler.current_level.get_node_or_null("Player")
	if player:
		$Sprite.look_at(player.global_position)
	if chase ==  true:
		velocity = Vector2.ZERO
		if player != null:
			velocity = position.direction_to(player.position) * speed
		velocity = move_and_slide(velocity)
		
	if player in $damageArea.get_overlapping_bodies() and can_damage:
		get_node("AnimationPlayer").play("attack")
		player.health -= damage
		can_damage = false
		$damageTimer.start()
	
	if health <= 0:
		var blood = load("res://Scenes/Objects/Blood.tscn").instance()
		SceneHandler.current_level.add_child(blood)
		blood.global_position = global_position
		blood.rotation = global_position.angle_to_point(SceneHandler.current_level.get_node_or_null("Player").global_position)
		queue_free()
	
	$Health.value = health * 100/maxhealth


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		print("pede")
		chase = true

func _on_Area2D_body_exited(body):
	if body.name == "Player":
		chase = false


func _on_damageTimer_timeout():
	can_damage = true
