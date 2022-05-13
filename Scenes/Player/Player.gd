extends KinematicBody2D

export (int) var speed = 200
export (PackedScene) var ps_bomb

var velocity = Vector2()

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
	var bomb = ps_bomb.instance()
	bomb.position = position
	get_parent().add_child(bomb)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _unhandled_input(event):
	if event.is_action_pressed("bomb"):
		place_bomb()

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
