extends "res://Scenes/Powerup/powerup.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func make_bonus(body):
	body.bomb_range += 1
	.make_bonus(body)
