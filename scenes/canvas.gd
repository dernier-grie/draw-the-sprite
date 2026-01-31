extends Control
class_name DrawCanvas

@export_group("Line options")
@export var line_width: float = 10.0
@export var line_color: Color = Color.DIM_GRAY
@export var line_distance_min = 5.0

var is_drawing: bool
var last_point: Vector2 = Vector2.ZERO

var current_line: PackedVector2Array
var lines: Array[PackedVector2Array]

func _ready() -> void:
	current_line = PackedVector2Array()
	lines = []
	pass

func _draw() -> void:
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
