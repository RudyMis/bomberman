extends Node



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(_e):
	if Input.is_action_just_pressed("reload"):
		var res = get_tree().reload_current_scene()
		if res != OK:
			print("Error reloading scene: " + res)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
