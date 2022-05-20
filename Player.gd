extends KinematicBody2D


export var run_speed = 60
export var drag = 0.9
var move_dir = Vector2.ZERO
var speed = Vector2.ZERO


func _ready():
	pass

func get_input():
	move_dir = Vector2.ZERO
	if Input.is_action_pressed("move_left"):
		move_dir.x -= 1
	if Input.is_action_pressed("move_right"):
		move_dir.x += 1
	if Input.is_action_pressed("move_up"):
		move_dir.y -= 1
	if Input.is_action_pressed("move_down"):
		move_dir.y += 1
	
	#pick u a weapon
	if Input.is_action_pressed("pick_up"):
		for body in $Area2D.get_overlapping_bodies():
			if body.is_in_group("Weapons"):
				body.queue_free()


func _physics_process(delta):
	get_input()
	speed = (speed + move_dir.normalized() * run_speed) * drag
	move_and_slide(speed)
	
	
	# Rotate player towards mouse
	get_node("Sprite").rotation = lerp_angle(get_node("Sprite").rotation, get_global_mouse_position().angle_to_point(position), 0.1)


