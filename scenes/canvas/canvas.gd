extends Control
class_name DrawCanvas

@export_group("Line options")
@export var line_width: float = 10.0
@export var line_color: Color = Color.DIM_GRAY
@export var line_distance_min = 5.0

@export_group("Points options")
@export var points: PackedVector2Array
@export var points_radius: float = 7.0
@export var points_color: Color = Color.DIM_GRAY

@export_group("Draw options")
@export var frame_size: float= 408.0
@export var threshold_margin: float = 0.0

@export_group("Particle options")
@export var particle_color: Color = Color.ORANGE

signal drawn

var is_drawing: bool
var last_point: Vector2 = Vector2.ZERO

var current_line: PackedVector2Array
var lines: Array[PackedVector2Array]

var current_points: PackedVector2Array

var rect: Rect2
var threshold_squared: float

func _ready() -> void:
	threshold_squared = pow(points_radius + line_width / 2.0 + threshold_margin, 2)
	resized.connect(_set_canvas_items)

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
			
			if rect.has_point(pos):
				_test_point_overlap(pos)
		queue_redraw()

func _set_canvas_items():
	current_line = PackedVector2Array()
	lines = []
	_set_current_points()
	_set_rect()
	queue_redraw()

func _set_current_points():
	current_points = PackedVector2Array()
	for point in points:
		current_points.append(size / 2  + point * frame_size)	

func _set_rect():
	rect = Rect2(size.x / 2  - frame_size / 2, size.y / 2  - frame_size / 2, frame_size, frame_size)

func _test_point_overlap(pos: Vector2):
	for i in range(current_points.size() - 1, -1, -1):
		if pos.distance_squared_to(current_points[i]) < threshold_squared:
			current_points.remove_at(i)
			ParticlesSpawner.request_star(get_global_transform() * pos, particle_color)
			if current_points.size() == 0:
				drawn.emit()
			break
