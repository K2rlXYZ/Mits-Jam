extends StaticBody2D


export(Texture) var idle
export(Texture) var picked_up
var damage = 20
var ammo = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func attack():
	for enemy in get_tree().get_nodes_in_group("Enemies"):
		var dist = enemy.global_position.distance_to(global_position)
		if dist < 100:
			enemy.health-=damage
			ammo -= 1
			if ammo == 0:
				get_parent().get_parent().has_weapon = false
				get_parent().get_parent().weapon = null
				get_parent().remove_child(self)
				queue_free()


func change_state():
	if $Sprite.texture == idle:
		$Sprite.texture = picked_up
	else:
		$Sprite.texture = idle
