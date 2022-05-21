extends KinematicBody2D

var velocity = Vector2.ZERO
var speed = 150
var maxhealth = 500
var health = maxhealth
var chase = false
var can_damage = true
export var damage = 45

func _ready():
	pass 

func _physics_process(delta):
	var player = SceneHandler.current_level.get_node_or_null("Player")
	if player:
		$Sprite.look_at(player.global_position)
	if chase ==  true:
		velocity = Vector2.ZERO
		if player != null:
			velocity = position.direction_to(player.position) * speed
		velocity = move_and_slide(velocity)
		
	if player in $Damage_area.get_overlapping_bodies() and can_damage:
		print(player.health)
		player.health -= damage
		can_damage = false
		$Damage_timer.start()
	
	if health <= 0:
		var blood = load("res://Scenes/Objects/Blood.tscn").instance()
		SceneHandler.current_level.add_child(blood)
		blood.global_position = global_position
		blood.rotation = global_position.angle_to_point(get_tree().get_root().get_node(Globals.level).get_node_or_null("Player").global_position)
		queue_free()
	
	$Health.value = health * 100/maxhealth





func _on_Damage_timer_timeout():
	can_damage = true


func _on_Seek_area_body_entered(body):
	if body.name == "Player":
		print("pede")
		chase = true


func _on_Seek_area_body_exited(body):
	if body.name == "Player":
		chase = false

