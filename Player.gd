
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
	
	if Input.is_action_just_pressed("pick_up"):
		#pick up a weapon
		if has_weapon == false:
			for body in $Area2D.get_overlapping_bodies():
				if body.is_in_group("Weapons") and has_weapon == false:
					reparent(body, $Pivot/Attach)
					has_weapon = true
					weapon = body
					print("uus relv")
					if weapon.is_in_group("Heals"):
						weapon.give_health()
					weapon.position = Vector2.ZERO
					weapon.change_state()
		else:
			# drop weapon
			reparent(weapon, self.get_parent().get_node("Weapons"))
			weapon.global_position = global_position
			weapon.change_state()
			has_weapon = false
			
			var last_weapon = weapon
			weapon = null
			
			
			# replace weapon?
			for body in $Area2D.get_overlapping_bodies():
				if body.is_in_group("Weapons") and has_weapon == false and body != last_weapon:
					reparent(body, $Pivot/Attach)
					has_weapon = true
					weapon = body
					print("teine relv")
					if body.animation == "swing":
						self
					if weapon.is_in_group("Heals"):
						weapon.give_health()
						
					weapon.position = Vector2.ZERO
					weapon.change_state()
	
	#deal damage
	if Input.is_action_just_pressed("attack") and has_weapon and !get_node("AnimationPlayer").is_playing() and weapon.can_shoot == true:
		get_node("AnimationPlayer").play(weapon.animation)
		# animation kutsub funktsiooni attack()
	
	if Input.is_action_just_pressed("pause"):
		SceneHandler.load_pause_screen()
	
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
		var pos = global_position
		var camera = $Camera2D
		reparent(camera, SceneHandler.current_level)
		camera.position = pos
		queue_free()
		SceneHandler.load_death_screen()
	
	
	
	# Rotate player towards mouse
	get_node("Pivot").rotation = lerp_angle(get_node("Pivot").rotation, get_global_mouse_position().angle_to_point(global_position), 0.1)


func reparent(child: Node, new_parent: Node):
	var old_parent = child.get_parent()
	old_parent.remove_child(child)
	new_parent.add_child(child)

func attack():
	weapon.attack()
	get_node("Camera2D").add_trauma(0.4)
