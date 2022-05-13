extends Node2D

class_name Bomb
func is_class(name): return "Bomb" || .is_class(name)
func get_class(): return "Bomb"

# [Bomb setup]
export (Vector2) var cell_size = Vector2(40, 40)
export (Vector2) var cell_offset = Vector2.ZERO
export (float) var wait_time = 3.0
export (int) var number_of_ticks = 2

# [Animation]
export (Vector2) var tick_scale = Vector2(1.2, 1.2)
export (float) var animation_time = 0.1
export (Array, Color) var modulates = [Color.yellow, Color.red]

# [Explosion properties]
export (int) var explosion_radius = 64
export (float) var explosion_time = 2

onready var tw_animation = $animation_tween
onready var t_tick = $tick_timer
onready var par_explosion = $explosion_particles
onready var what_explodes = $explodes
onready var explosion_rays = $explosion_rays

var current_tick = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	# Doesn't tick at start and end
	snap_to_cells()
	t_tick.wait_time = wait_time / (number_of_ticks + 1)
	t_tick.connect("timeout", self, "tick")
	t_tick.start()
	for ray in explosion_rays.get_children():
		if ray as RayCast2D != null:
			ray.cast_to.x = explosion_radius

func restart():
	t_tick.stop()
	current_tick = 0
	t_tick.start()

func tick():
	if current_tick > number_of_ticks:
		return
	if current_tick == number_of_ticks:
		t_tick.stop()
		explode()
		return
	modulate = modulates[current_tick]
	current_tick += 1
	tw_animation.interpolate_property(self, "scale", tick_scale, Vector2.ONE, animation_time, Tween.TRANS_LINEAR)
	tw_animation.start()

func explode():
	what_explodes.call_deferred("queue_free")
	for ray in explosion_rays.get_children():
		if ray as RayCast2D != null:
			ray.explode()
	
	modulate = Color.white
	par_explosion.restart()
	yield(get_tree().create_timer(par_explosion.lifetime), "timeout")
	call_deferred("queue_free")

func snap_to_cells():
	position -= Vector2(int(position.x) % int(cell_size.x), int(position.y) % int(cell_size.y))
	position += cell_size / 2
