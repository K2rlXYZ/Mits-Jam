extends KinematicBody2D

var vec = Vector2.ZERO
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(Texture) var idle
export(Texture) var picked_up

var dir = Vector2.ZERO
var fly_speed = 0
var damage = 30
var drag = 0.1
var flying = false
var can_shoot
var ammo = 15


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _physics_process(delta):
	if flying:
		fly_speed -= drag
		position += dir * fly_speed

func attack():
	flying = true
	fly_speed = 10
	var pos = global_position
	get_tree().get_root().get_node(Globals.level).add_child(self)
	get_tree().get_root().get_node(Globals.level + "/Player").has_weapon = false
	get_tree().get_root().get_node(Globals.level + "/Player").weapon = null
	get_tree().get_root().get_node(Globals.level + "/Player").remove_child(self)
	position = pos
	vec = (get_global_mouse_position()-global_position).normalized()
	pos.x += 80*vec.x
	pos.y += 80*vec.y
	position = pos
	dir = (get_global_mouse_position() - position).normalized()
	
func change_state():
	if $Sprite.texture == idle:
		$Sprite.texture = picked_up
	else:
		$Sprite.texture = idle


func _on_Area2D_body_entered(body):
	if body.is_in_group("Enemies") and flying:
		body.health -= damage
		fly_speed = 0
		flying = false
