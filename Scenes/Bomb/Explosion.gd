extends RayCast2D

onready var bone = $Skeleton2D/Bone2D
onready var explosion_cast = $explosion

func explode():
	var hit_position = get_collision_point() - global_position if is_colliding() else cast_to
	
	# Cast to position is applied before rotation
	explosion_cast.cast_to = Vector2(hit_position.length(), 0)
	explosion_cast.enabled = true
	bone.position = hit_position

func _ready():
	bone.position = Vector2.ZERO
