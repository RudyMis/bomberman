extends KinematicBody2D

export (int) var speed = 200
export (PackedScene) var ps_bomb

var bombs = 2;
export (int) var bomb_range = 1
export (int) var radious_range_const = 64
var velocity = Vector2()
onready var label = $Label

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed

func place_bomb():
	if bombs > 0:
		var bomb = ps_bomb.instance()
		bomb.position = position
		bomb.explosion_radius = bomb_range * radious_range_const
		get_parent().add_child(bomb)
		bomb.bomberman = self
		bombs -= 1
		change_text()
		
# Called when the node enters the scene tree for the first time.
func _ready():
	change_text()
	pass # Replace with function body.

func _unhandled_input(event):
	if event.is_action_pressed("bomb"):
		place_bomb()

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
	
func change_text():
	label.set_text("Range: " + str(bomb_range) + "\n" + "Bombs: " + str(bombs))
	
