extends Node

@export_group("Draw options")
@export var animal_data: AnimalData
@export var canvas_scene: PackedScene
@export var reveal_duration: float = 0.5

@export_group("UI options")
@export var ui_color: Color = Color.hex(0x353541ff)

@onready var canvas_container: Control = $CanvasContainer
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
	canvas.drawn.connect(_on_canvas_drawn)
	
	for child in canvas_container.get_children():
		child.queue_free()
	canvas_container.add_child(canvas)

func _on_canvas_drawn():
	var tween = create_tween()
	tween.tween_property(texture_rect_animal, "modulate:a", 1.0, reveal_duration)
	tween.parallel().tween_property(texture_rect_frame, "modulate:a", 0.0, reveal_duration)
	tween.parallel().tween_property(canvas_container, "modulate:a", 0.0, reveal_duration)
