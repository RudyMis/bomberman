extends KinematicBody2D

class_name Player
func is_class(name): return "Player" || .is_class(name)
func get_class(): return "Player"

export (int) var speed = 200
export (PackedScene) var ps_bomb
export (String) var player = "1"
export (Array, Resource) var cats_animations

var rng = RandomNumberGenerator.new()
var bombs = 2;
export (int) var bomb_range = 1
var has_shield = true
export (int) var radious_range_const = 64
var velocity = Vector2()
onready var label = $Label
onready var sprite = $Sprite
onready var hurt_sound = $Hurt

var iframes_time = 3
var has_iframes = false
var iframes_timer = Timer.new()

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("right" + player):
		velocity.x += 1
		sprite.play("right");
	if Input.is_action_pressed("left" + player):
		velocity.x -= 1
		sprite.play("left");
	if Input.is_action_pressed("down" + player):
		velocity.y += 1
		sprite.play("down");
	if Input.is_action_pressed("up" + player):
		velocity.y -= 1
		sprite.play("up");
	velocity = velocity.normalized() * speed
	if velocity == Vector2.ZERO:
		sprite.play("nothing");

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
	iframes_timer.set_wait_time(iframes_time)
	iframes_timer.connect("timeout", self, "_on_timer_timeout")
	add_child(iframes_timer)
	rng.randomize()
	var seed_cat = rng.randi()
	rng.set_seed(int(player) + seed_cat)
	var random = rng.randi_range(0, cats_animations.size() - 1)
	sprite.frames = cats_animations[random]
	pass # Replace with function body.

func _unhandled_input(event):
	if event.is_action_pressed("bomb" + player):
		place_bomb()

func push_objects(delta):
	# Test for collision without moving
	var collision = move_and_collide(velocity * delta, true, true, true)
	if collision == null:
		return
	if collision.collider.has_method("push"):
		var direction = -collision.normal
		if (velocity != Vector2.ZERO):
			collision.collider.push(direction, speed)

func _physics_process(delta):
	get_input()
	push_objects(delta)
	velocity = move_and_slide(velocity)

func change_text():
  get_parent().get_node("StatsPlayer" + player).set_text("Player " + player + ":\n" + "Range: " + str(bomb_range) + "\n" + "Bombs: " + str(bombs))

func _on_timer_timeout():
	has_iframes = false
	sprite.modulate = Color(1, 1, 1)

func explode():
	# TODO: Add logic dependent on player's power ups
	if has_iframes:
		return
	hurt_sound.play()
	if has_shield:
		has_shield = false
		has_iframes = true
		iframes_timer.start()
		sprite.modulate = Color(0.5, 0.5, 0.5)
		return
	call_deferred("queue_free")
