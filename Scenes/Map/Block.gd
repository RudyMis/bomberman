extends Node2D

class_name Block
func is_class(name): return "Block" || .is_class(name)
func get_class(): return "Block"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (Array, PackedScene) var ps_powerup
var rng = RandomNumberGenerator.new()
onready var sound = $Sound

func explode():
	call_deferred("queue_free")
	var random = rng.randi_range(0, ps_powerup.size() + 1)
	if (random < ps_powerup.size()):
		var power = ps_powerup[random].instance()
		power.position = position
		get_parent().add_child(power)
	
	# Play sound and destroy itself
	# TODO: Disable hitbox here
	visible = false
	sound.play()
	yield(sound, "finished")
	call_deferred("queue_free")


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	pass # Replace with function body.

