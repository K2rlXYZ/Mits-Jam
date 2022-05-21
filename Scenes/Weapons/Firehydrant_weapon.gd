extends StaticBody2D


export(Texture) var idle
export(Texture) var picked_up
var damage = 20
onready var pos = global_position
var effect
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func attack():
	for enemy in get_tree().get_nodes_in_group("Enemies"):
		var dist = enemy.global_position.distance_to(global_position)
		if dist < 100:
			enemy.health-=damage


func change_state():
	if $Sprite.texture == idle:
		$Sprite.texture = picked_up
		effect = load("res://Assets/Particles/Firehydrant_effect.tscn").instance()
		get_tree().get_root().get_node(Globals.level).add_child(effect)
		pos.x += 48
		effect.position = pos
		effect.emitting =  true
	else:
		$Sprite.texture = idle

