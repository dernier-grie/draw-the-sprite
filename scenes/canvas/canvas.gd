extends Control
class_name DrawCanvas

@export_group("Line options")
@export var line_width: float = 10.0
@export var line_color: Color = Color.DIM_GRAY
@export var line_distance_min = 5.0

@export_group("Points options")
@export var points = [Vector2( -0.002, -0.404), Vector2( -0.017, -0.429), Vector2( 0.017, -0.429), Vector2( -0.054, -0.429), Vector2( 0.054, -0.429), Vector2( -0.078, -0.409), Vector2( 0.078, -0.409), Vector2( -0.081, -0.363), Vector2( 0.081, -0.363), Vector2( -0.103, -0.343), Vector2( 0.103, -0.343), Vector2( -0.105, -0.299), Vector2( 0.105, -0.299), Vector2( -0.091, -0.27), Vector2( 0.091, -0.27), Vector2( -0.096, -0.23), Vector2( 0.096, -0.23), Vector2( -0.078, -0.199), Vector2( 0.078, -0.199), Vector2( -0.051, -0.167), Vector2( 0.051, -0.167), Vector2( -0.01, -0.154), Vector2( 0.01, -0.154), Vector2( -0.02, -0.049), Vector2( 0.02, -0.049), Vector2( -0.064, -0.044), Vector2( 0.064, -0.044), Vector2( -0.115, -0.02), Vector2( 0.115, -0.02), Vector2( -0.152, 0.029), Vector2( 0.152, 0.029), Vector2( -0.167, 0.078), Vector2( 0.167, 0.078), Vector2( -0.164, 0.135), Vector2( 0.164, 0.135), Vector2( -0.142, 0.169), Vector2( 0.142, 0.169), Vector2( -0.103, 0.196), Vector2( 0.103, 0.196), Vector2( -0.059, 0.208), Vector2( 0.059, 0.208), Vector2( -0.01, 0.213), Vector2( 0.01, 0.213), Vector2( -0.088, 0.23), Vector2( 0.088, 0.23), Vector2( -0.12, 0.255), Vector2( 0.12, 0.255), Vector2( -0.137, 0.304), Vector2( 0.137, 0.304), Vector2( -0.118, 0.35), Vector2( 0.118, 0.35), Vector2( -0.074, 0.368), Vector2( 0.074, 0.368), Vector2( -0.032, 0.358), Vector2( 0.032, 0.358), Vector2( 0.002, 0.331), Vector2( -0.181, 0.042), Vector2( 0.181, 0.042), Vector2( -0.189, -0.015), Vector2( 0.189, -0.015), Vector2( -0.218, -0.054), Vector2( 0.218, -0.054), Vector2( -0.277, -0.069), Vector2( 0.277, -0.069), Vector2( -0.333, -0.056), Vector2( 0.333, -0.056), Vector2( -0.36, -0.025), Vector2( 0.36, -0.025), Vector2( -0.375, 0.025), Vector2( 0.375, 0.025), Vector2( -0.368, 0.074), Vector2( 0.368, 0.074), Vector2( -0.338, 0.115), Vector2( 0.338, 0.115), Vector2( -0.294, 0.132), Vector2( 0.294, 0.132), Vector2( -0.238, 0.13), Vector2( 0.238, 0.13), Vector2( -0.206, 0.115), Vector2( 0.206, 0.115), Vector2( -0.189, 0.076), Vector2( 0.189, 0.076), Vector2( -0.159, 0.228), Vector2( 0.159, 0.228), Vector2( -0.201, 0.275), Vector2( 0.201, 0.275), Vector2( -0.233, 0.341), Vector2( 0.233, 0.341), Vector2( -0.245, 0.392), Vector2( 0.245, 0.392), Vector2( -0.248, 0.461), Vector2( 0.248, 0.461)]
@export var points_radius: float = 7.0
@export var points_color: Color = Color.DIM_GRAY
@export var frame_size: float= 408.0

var is_drawing: bool
var last_point: Vector2 = Vector2.ZERO

var current_line: PackedVector2Array
var lines: Array[PackedVector2Array]

var current_points: PackedVector2Array


func _ready() -> void:
	current_line = PackedVector2Array()
	lines = []
	
	current_points = PackedVector2Array()
	for point in points:
		current_points.append(size / 2  + point * frame_size)	

func _draw() -> void:
	for point in current_points:
		draw_circle(point, points_radius, points_color)

	if current_line.size() > 1:
		draw_polyline(current_line, line_color, line_width)
	
	for line in lines:
		draw_polyline(line, line_color, line_width)
		
func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		is_drawing = event.is_pressed()
		
		if not is_drawing and current_line.size() > 1:
			last_point = Vector2.ZERO
			lines.append(current_line)
			current_line = PackedVector2Array()
	
	if is_drawing and (event is InputEventMouseMotion):
		var pos: Vector2 = event.position
		var pos_distance = pos.distance_to(last_point)
		if pos_distance > line_distance_min:
			last_point = pos
			current_line.append(pos)
		queue_redraw()
