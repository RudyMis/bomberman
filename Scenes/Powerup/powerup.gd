extends Node

class_name Powerup

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func make_bonus(body):
	pass

func explode():
	call_deferred("queue_free")

func _on_Powerup_body_entered(body):
	if (body.has_method("place_bomb")):
		make_bonus(body)
		body.change_text()
	
	call_deferred("queue_free")
	
