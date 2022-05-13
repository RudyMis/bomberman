# Used only to spawn other scenes

extends TileMap

export (Array, PackedScene) var scenes
export (float) var place_chance = 0.9

func spawn_obstacles():
	randomize()
	var cells_pos = get_used_cells()
	for pos in cells_pos:
		var rand = randf()
		if rand <= place_chance:
			var cell_type = get_cellv(pos)
			var block = scenes[cell_type].instance()
			block.position = map_to_world(pos)
			get_parent().call_deferred("add_child", block)

func _ready():
	visible = false
	spawn_obstacles()
	
