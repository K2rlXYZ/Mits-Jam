extends StaticBody2D


export(Texture) var idle
export(Texture) var picked_up
var damage = 20
var ammo = 10
var can_shoot = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func attack():
	for enemy in get_tree().get_nodes_in_group("Enemies"):
		var dist = enemy.global_position.distance_to(global_position)
		if dist < Globals.weapon_range:
			enemy.health-=damage
			ammo -= 1
			if ammo == 0:
				get_tree().get_root().get_node(Globals.level + "/Player").has_weapon = false
				get_tree().get_root().get_node(Globals.level + "/Player").weapon = null
				get_parent().remove_child(self)
				queue_free()


func change_state():
	if $Sprite.texture == idle:
		$Sprite.texture = picked_up
	else:
		$Sprite.texture = idle

