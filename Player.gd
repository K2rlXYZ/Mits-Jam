extends KinematicBody2D


export var run_speed = 60
export var drag = 0.9
var move_dir = Vector2.ZERO
var speed = Vector2.ZERO
var has_weapon = false
var weapon = null
var maxhealth = 200
var health = maxhealth

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
	
	#pick up a weapon
	if Input.is_action_just_pressed("pick_up") and has_weapon == false:
		for body in $Area2D.get_overlapping_bodies():
			if body.is_in_group("Weapons") and has_weapon == false:
				reparent(body, $Pivot)
				has_weapon = true
				weapon = body
				weapon.position = Vector2.ZERO
				weapon.change_state()
			
	
	#drop weapon
	if Input.is_action_just_pressed("drop") and has_weapon == true:
		reparent(weapon, self.get_parent())
		weapon.position = position
		weapon.change_state()
		has_weapon = false
		weapon = null
	
	#deal damage
	if Input.is_action_just_pressed("attack") and has_weapon:
		weapon.attack()
	
	
func get_weapon():
	for child in get_children():
		if child.is_in_group("Weapons"):
			return child

func _physics_process(delta):
	get_input()
	speed = (speed + move_dir.normalized() * run_speed) * drag
	move_and_slide(speed)
	
	$Health.value = int(health*100/maxhealth)
	if health <= 0:
		queue_free()
	
	
	
	# Rotate player towards mouse
	get_node("Pivot").rotation = lerp_angle(get_node("Pivot").rotation, get_global_mouse_position().angle_to_point(position), 0.1)


func reparent(child: Node, new_parent: Node):
	var old_parent = child.get_parent()
	old_parent.remove_child(child)
	new_parent.add_child(child)
