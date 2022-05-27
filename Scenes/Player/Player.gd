extends KinematicBody2D

class_name Player
func is_class(name): return "Player" || .is_class(name)
func get_class(): return "Player"

export (int) var speed = 200
export (PackedScene) var ps_bomb
export (String) var player = "1"

var bombs = 2;
export (int) var bomb_range = 1
export (int) var radious_range_const = 64
var velocity = Vector2()
onready var label = $Label

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("right" + player):
		velocity.x += 1
	if Input.is_action_pressed("left" + player):
		velocity.x -= 1
	if Input.is_action_pressed("down" + player):
		velocity.y += 1
	if Input.is_action_pressed("up" + player):
		velocity.y -= 1
	velocity = velocity.normalized() * speed

func place_bomb():
	if bombs > 0:
		var bomb = ps_bomb.instance()
		bomb.position = position
		bomb.explosion_radius = 32 + 	bomb_range * radious_range_const
		get_parent().add_child(bomb)
		bomb.bomberman = self
		bombs -= 1
		change_text()
		
# Called when the node enters the scene tree for the first time.
func _ready():
	change_text()
	pass # Replace with function body.

func _unhandled_input(event):
	if event.is_action_pressed("bomb" + player):
		place_bomb()

func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)

func change_text():
	label.set_text("Range: " + str(bomb_range) + "\n" + "Bombs: " + str(bombs))

func explode():
	pass # Add logic dependent on player's power ups
	call_deferred("queue_free")
