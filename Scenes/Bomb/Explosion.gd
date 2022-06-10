extends RayCast2D

onready var bone: Bone2D = $Skeleton2D/Bone2D
onready var explosion_cast: RayCast2D = $explosion
var check_hitbox = false

func explode():
	visible = true
	var hit_position = global_position - get_collision_point() if is_colliding() else cast_to
	
	# Position is applied before rotation
	hit_position = Vector2(hit_position.length(), 0)
	if is_colliding() && get_collider().has_method("get_class") && get_collider().get_class() == "Block":
		hit_position.x += 63
	explosion_cast.cast_to = hit_position
	explosion_cast.enabled = true
	bone.position = hit_position
	check_hitbox = true

func _ready():
	visible = false
	bone.position = Vector2.ZERO

func _process(_delta):
	if check_hitbox:
		check_hitbox = false
		explosion_cast.force_raycast_update()
		if explosion_cast.is_colliding():
			var collider = explosion_cast.get_collider()
			if collider == null:
				return
	  # Owner should have function to destroy itself
			if collider.has_method("explode"):
				if collider.get_class() == "Player" || collider.get_class() == "Powerup":
					check_hitbox = true
				collider.explode()
