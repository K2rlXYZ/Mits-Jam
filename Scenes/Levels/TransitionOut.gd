extends AnimationPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
var skipped = false
	
func _process(_delta):
	if Input.is_action_pressed("skip") and not skipped:
		skipped = true
		self.seek(23.5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
