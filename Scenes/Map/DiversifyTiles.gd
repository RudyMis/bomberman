extends TileMap

func diversify_tiles():
	randomize()
	var cells_pos = get_used_cells()
	var tile_ids = tile_set.get_tiles_ids()
	var number_of_tiles = tile_ids.size()
	for pos in cells_pos:
		var rand = randi() % number_of_tiles
		set_cellv(pos, tile_ids[rand])

func _ready():
	diversify_tiles()
	
