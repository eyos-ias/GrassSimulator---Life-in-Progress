extends Node2D

@export var length = 100

var curve : BezierCurve

var wind_force : Vector2 = Vector2.ZERO
var vibrations_radius : float = 10.0


var base_point : Vector2
var middle_point : Vector2
var tip_point : Vector2

var rest_tip_point : Vector2

func _ready():
	var seperation = length / 2
	base_point = Vector2.ZERO
	middle_point = base_point + seperation * Vector2.UP
	tip_point = middle_point + seperation * Vector2.UP
	rest_tip_point = tip_point
	
	create_bezier_curve()

func _process(delta):
	# apply external wind force
	tip_point += wind_force * delta

	# equilbrate forces
	var reset_force = rest_tip_point - tip_point
	tip_point += reset_force * delta
	
	# add vabrations
	tip_point += Vector2(randf_range(-vibrations_radius, vibrations_radius), randf_range(-vibrations_radius, vibrations_radius)) * delta
	
	# redraw
	update_curve()

func update_curve():
	curve.set_curve_points([base_point, middle_point, tip_point])
	
func create_bezier_curve():
	curve = BezierCurve.new()
	curve.set_curve_points([base_point, middle_point, tip_point])
	
	curve.begin_cap_mode = Line2D.LINE_CAP_ROUND
	curve.end_cap_mode = Line2D.LINE_CAP_ROUND
	curve.joint_mode = Line2D.LINE_JOINT_ROUND
	curve.antialiased = true
	
	var gradient = Gradient.new()
	var width_curve = Curve.new()
	width_curve.add_point(Vector2(0, 0.3))
	width_curve.add_point(Vector2(1, 1))
	
	gradient.colors = [Color.DARK_GREEN, Color.LAWN_GREEN] 
	gradient.offsets = [0.2, 0.8]
	curve.gradient = gradient
	curve.width_curve = width_curve
	
	add_child(curve)
