extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (Array, PackedScene) var ps_powerup
var rng = RandomNumberGenerator.new()
onready var sound = $Sound

func explode():
	var random = rng.randi_range(0, 4)
	if (random < 3):
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

