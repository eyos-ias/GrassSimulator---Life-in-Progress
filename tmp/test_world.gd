extends Node2D

@onready var grass_tilemap = $GrassTilemap
@onready var filedwidth_slider = $Control/Panel/VBoxContainer/HBoxContainer4/fieldwidth

func _on_windx_value_changed(value):
	grass_tilemap.set_horizontal_wind_force(value)

func _on_windy_value_changed(value):
	grass_tilemap.set_vertical_wind_force(value)

func _on_stretchradius_value_changed(value):
	grass_tilemap.set_stretch_radius(value)
