extends Node



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if Input.is_action_just_pressed("reload"):
		get_tree().reload_current_scene()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
