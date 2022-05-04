extends Node2D

export (float) var wait_time = 3.0
export (int) var number_of_ticks = 2
export (Vector2) var tick_scale = Vector2(1.2, 1.2)
export (float) var animation_time = 0.1
export (Array, Color) var modulates = [Color.yellow, Color.red]

onready var tw_animation = $animation_tween
onready var t_tick = $tick_timer
onready var par_explosion = $explosion
onready var explodes = $explodes

var current_tick = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	# Doesn't tick at start and end
	t_tick.wait_time = wait_time / (number_of_ticks + 1)
	t_tick.connect("timeout", self, "tick")
	t_tick.start()

func restart():
	t_tick.stop()
	current_tick = 0
	t_tick.start()

func tick():
	if current_tick == number_of_ticks:
		t_tick.stop()
		explode()
		return
	modulate = modulates[current_tick]
	current_tick += 1
	tw_animation.interpolate_property(self, "scale", tick_scale, Vector2.ONE, animation_time, Tween.TRANS_LINEAR)
	tw_animation.start()

func explode():
	explodes.call_deferred("queue_free")
	modulate = Color.white
	par_explosion.restart()
	yield(get_tree().create_timer(par_explosion.lifetime), "timeout")
	call_deferred("queue_free")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
