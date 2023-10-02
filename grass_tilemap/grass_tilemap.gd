
extends TileMap

var grass_field_scene = preload("res://grass_field/grass_field.tscn")

var fields = []

func _ready():
	for cell in get_used_cells(0):
		var pos = map_to_local(cell)
		var cell_width = cell_quadrant_size
		
		var grass_field = grass_field_scene.instantiate()
		grass_field.width = cell_width
		grass_field.spacing = randf_range(0.2, 0.8)
		grass_field.position = pos - Vector2(cell_width/2, -cell_quadrant_size/2)
		add_child(grass_field)
		
		fields.append(grass_field)
	
	
	set_layer_enabled(0, false)
	
	force_update()
	
func get_fields():
	return fields
	
func set_stretch_radius(value):
	for field in get_fields():
		for child in field.get_children():
			child.vibrations_radius = value

func set_vertical_wind_force(value):
	for field in get_fields():
		for child in field.get_children():
			child.wind_force.y = value

func set_horizontal_wind_force(value):
	for field in get_fields():
		for child in field.get_children():
			child.wind_force.x = value

func _process(delta):
	pass
