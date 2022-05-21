extends StaticBody2D


export(Texture) var idle
export(Texture) var picked_up
var damage = 20
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


func change_state():
	if $Sprite.texture == idle:
		$Sprite.texture = picked_up
	else:
		$Sprite.texture = idle
