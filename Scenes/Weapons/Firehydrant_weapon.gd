extends StaticBody2D


export(Texture) var idle
export(Texture) var picked_up
var damage = 20
onready var pos = global_position
var effect
var loaded = false
var ammo = 10
var can_shoot = true
var animation = "swing"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func attack():
	for enemy in get_tree().get_nodes_in_group("Enemies"):
		var dist = enemy.global_position.distance_to(global_position)
		if dist < Globals.weapon_range:
			enemy.health-=damage
			$Hit.play()
			ammo -= 1
			if ammo == 0:
				SceneHandler.current_level.get_node("Player").has_weapon = false
				SceneHandler.current_level.get_node("Player").weapon = null
				get_parent().remove_child(self)
				queue_free()


func change_state():
	if $Sprite.texture == idle:
		$Sprite.texture = picked_up
		if not loaded:
			effect = load("res://Assets/Particles/Firehydrant_effect.tscn").instance()
			SceneHandler.current_level.add_child(effect)
			pos.x += 48
			effect.global_position = pos
			effect.emitting =  true
			loaded = true
	else:
		$Sprite.texture = idle

func reparent(child: Node, new_parent: Node):
	var old_parent = child.get_parent()
	old_parent.remove_child(child)
	new_parent.add_child(child)
