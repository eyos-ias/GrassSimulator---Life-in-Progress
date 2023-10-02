@tool
extends Node2D

@export var width = 100
@export var spacing : float = 0.2

var grass_scene : PackedScene = load("res://grass_field/grass_blade.tscn")

func _ready():
	if Engine.is_editor_hint(): return

	fill_field()

func fill_field():
	for child in get_children():
		child.queue_free()
	
	for i in range(-width/2, width/2):
		var grass = grass_scene.instantiate()
#		grass.width = randf_range(8.0, 16.0)
		grass.position = Vector2(i * randf_range(8, 24) * spacing, 0)
		grass.length = randi_range(32, 64)
		grass.wind_force = Vector2(10, 0)
		
		if abs(grass.position.x) - width <= 0:
			add_child(grass) 

func _process(delta):
	if Engine.is_editor_hint(): queue_redraw()
	
	
func _draw():
	if Engine.is_editor_hint():
		draw_line(Vector2(-width/2, 0), Vector2(width/2, 0), Color.MEDIUM_VIOLET_RED, 2)
