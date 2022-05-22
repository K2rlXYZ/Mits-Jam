extends KinematicBody2D

var velocity = Vector2.ZERO


var deafult_speed = 150
var angry_speed = 240
var speed = deafult_speed


var deafult_jump_speed = 500
var angry_jump_speed = 800
var jump_speed = deafult_jump_speed

var is_angry = false

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
		$Pivot.look_at(player.global_position)
	if chase ==  true:
		velocity = Vector2.ZERO
		if player != null:
			velocity = position.direction_to(player.position) * speed
		velocity = move_and_slide(velocity)
		
	if player in $Damage_area.get_overlapping_bodies() and can_damage:
		can_damage = false
		if randi() % 2:
			get_node("AnimationPlayer").play("left_swing")
		else:
			get_node("AnimationPlayer").play("right_swing")
	
	if health <= 0:
		var blood = load("res://Scenes/Objects/Blood.tscn").instance()
		SceneHandler.current_level.add_child(blood)
		blood.global_position = global_position
		blood.rotation = global_position.angle_to_point(SceneHandler.current_level.get_node_or_null("Player").global_position)
		queue_free()
	
	$Health.value = health * 100/maxhealth
	
	
	if health < maxhealth / 2 and !is_angry:
		is_angry = true
		deafult_speed = angry_speed
		deafult_jump_speed = angry_jump_speed


func attack():
	if SceneHandler.current_level.get_node_or_null("Player") in $Damage_area.get_overlapping_bodies():
		SceneHandler.current_level.get_node_or_null("Player").health -= damage
	$Damage_timer.start()


func _on_Damage_timer_timeout():
	can_damage = true


func _on_Seek_area_body_entered(body):
	if body.name == "Player":
		chase = true
		# zoom cameera out
		body.get_node("Camera2D").zoom = Vector2.ONE * 1.2


func _on_Seek_area_body_exited(body):
	if body.name == "Player":
		chase = false



func _on_Dash_timer_timeout():
	speed = deafult_jump_speed
	yield(get_tree().create_timer(1), "timeout")
	speed = deafult_speed
