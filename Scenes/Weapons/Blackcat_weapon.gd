extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(Texture) var idle
export(Texture) var picked_up
var vec = Vector2.ZERO
var can_shoot
var ammo = 10
var furb_preload = preload("res://Scenes/Weapons/furball.tscn")
var animation = "shoot"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.texture = idle


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
var player_nearby
var damage = 20  

func _physics_process(_delta):
	pass
	
	
func attack():
	if can_shoot:
		$Meow.play()
		var furb = furb_preload.instance()
		SceneHandler.current_level.add_child(furb)
		vec = (get_global_mouse_position()-global_position).normalized()
		var pos = global_position
		pos.x += 80*vec.x
		pos.y += 80*vec.y
		furb.global_position = pos
		furb.shoot(get_global_mouse_position())
		can_shoot = false
		$Timer.start()
		ammo -= 1
		if ammo == 0:
			SceneHandler.current_level.get_node("Player").has_weapon = false
			SceneHandler.current_level.get_node("Player").weapon = null
			get_parent().remove_child(self)
			queue_free()

func change_state():
	if $Sprite.texture == idle:
		$Sprite.texture = picked_up
	else:
		$Sprite.texture = idle


func _on_Timer_timeout():
	can_shoot = true
