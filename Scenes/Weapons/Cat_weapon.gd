extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(Texture) var idle
export(Texture) var picked_up
var vec = Vector2.ZERO
var can_shoot

var furb_preload = preload("res://Scenes/Weapons/furball.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.texture = idle


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
var player_nearby
var damage = 20

func _physics_process(delta):
	pass
	
	
func attack():
	if can_shoot:
		var furb = furb_preload.instance()
		get_tree().get_root().get_node(Globals.level).add_child(furb)
		vec = (get_global_mouse_position()-global_position).normalized()
		var pos = global_position
		pos.x += 80*vec.x
		pos.y += 80*vec.y
		furb.position = pos
		furb.shoot(get_global_mouse_position())
		can_shoot = false
		$Timer.start()

func change_state():
	if $Sprite.texture == idle:
		$Sprite.texture = picked_up
	else:
		$Sprite.texture = idle


func _on_Timer_timeout():
	can_shoot = true
