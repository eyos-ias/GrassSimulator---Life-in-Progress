extends Line2D


class_name BezierCurve

var _points

func _ready():
	_points = points.duplicate()
	set_curve_points(_points)	

func set_curve_points(p):
	clear_points()
	draw_bezier_curve(p)

func draw_bezier_curve(points, num_segments=20):
	var num_points = len(points)
	var t_increment = 1.0 / num_segments
	
	if num_points < 3:
		print("At least 3 points are required to draw a Bezier curve.")
		return

	for i in range(num_points - 2):
		var p0 = points[i]
		var p1 = points[i + 1]
		var p2 = points[i + 2]

		for t in range(num_segments):
			var t_normalized = t * t_increment
			var u = 1 - t_normalized

			var x = u * u * p0.x + 2 * u * t_normalized * p1.x + t_normalized * t_normalized * p2.x
			var y = u * u * p0.y + 2 * u * t_normalized * p1.y + t_normalized * t_normalized * p2.y

			var start_point = Vector2(x, y)

			t_normalized = (t + 1) * t_increment
			u = 1 - t_normalized

			x = u * u * p0.x + 2 * u * t_normalized * p1.x + t_normalized * t_normalized * p2.x
			y = u * u * p0.y + 2 * u * t_normalized * p1.y + t_normalized * t_normalized * p2.y

			var end_point = Vector2(x, y)

			add_point(start_point)
			add_point(end_point)
