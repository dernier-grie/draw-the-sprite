extends Node

@export_group("Canvas options")
@export var animal_data: AnimalData
@export var canvas_scene: PackedScene

@export_group("UI options")
@export var ui_color: Color = Color.hex(0x353541ff)

@onready var canvas_container: Node = $CanvasContainer
@onready var texture_rect_animal: TextureRect = $AnimalContainer/TextureRect
@onready var texture_rect_frame: TextureRect = $FrameContainer/TextureRect

func _ready() -> void:
	_setup_animal()
	_setup_frame()
	_setup_canvas()

func _setup_animal():
	texture_rect_animal.texture = animal_data.texture
	texture_rect_animal.modulate.a = 0.0

func _setup_frame():
	texture_rect_frame.modulate = ui_color

func _setup_canvas():
	var canvas = canvas_scene.instantiate() as DrawCanvas
	canvas.points_color = ui_color
	canvas.line_color = ui_color
	canvas.points = animal_data.points
	canvas.frame_size = animal_data.texture.get_width()
	
	for child in canvas_container.get_children():
		child.queue_free()
	canvas_container.add_child(canvas)
