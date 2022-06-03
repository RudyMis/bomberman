extends Area2D

class_name Powerup
func is_class(name): return "Powerup" || .is_class(name)
func get_class(): return "Powerup"

onready var sound = $Sound

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func make_bonus(body):
	sound.play()
	visible = false
	yield(sound, "finished")
	call_deferred("queue_free")

func explode():
	call_deferred("queue_free")

func _on_Powerup_body_entered(body):
	if (body.has_method("place_bomb")):
		make_bonus(body)
		body.change_text()
	
	
