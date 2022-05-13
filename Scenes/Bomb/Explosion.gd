extends RayCast2D

onready var bone: Bone2D = $Skeleton2D/Bone2D
onready var explosion_cast: RayCast2D = $explosion

func explode():
	var hit_position = global_position - get_collision_point() if is_colliding() else cast_to
	
	# Position is applied before rotation
	hit_position = Vector2(hit_position.length(), 0)
	explosion_cast.cast_to = hit_position
	explosion_cast.enabled = true
	bone.position = hit_position

func _ready():
	bone.position = Vector2.ZERO

func _process(_delta):
	if explosion_cast.is_colliding():
		# Owner should have function to destroy itself
		if explosion_cast.get_collider() == null:
			return
		var collider = explosion_cast.get_collider()
		print(collider)
		if collider != null && collider.has_method("explode"):
			collider.explode()
