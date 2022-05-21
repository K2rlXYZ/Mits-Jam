extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(Texture) var idle
export(Texture) var picked_up

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
	for enemy in get_tree().get_nodes_in_group("Enemies"):
		var dist = enemy.global_position.distance_to(global_position)
		if dist < 100:
			enemy.health-=damage

func change_state():
	if $Sprite.texture == idle:
		$Sprite.texture = picked_up
	else:
		$Sprite.texture = idle
