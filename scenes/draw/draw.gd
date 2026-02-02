extends Node

@export_group("Draw options")
@export var animal_dataset: Array[AnimalData]
@export var canvas_scene: PackedScene
@export var reveal_duration: float = 0.5

@export_group("UI options")
@export var ui_color: Color = Color.hex(0x353541ff)

@onready var canvas_container: Control = $MarginContainer/CanvasContainer
@onready var texture_rect_animal: TextureRect = $AnimalContainer/TextureRect
@onready var texture_rect_frame: TextureRect = $FrameContainer/TextureRect

@onready var touch_hint_back: TouchHint = $ControlsContainer/TouchHintBack
@onready var touch_hint_restart: TouchHint = $ControlsContainer/TouchHintRestart

@onready var button_back: Button = $ControlsContainer/TouchHintBack/MarginContainer/PanelContainer/ButtonBack
@onready var button_restart: Button = $ControlsContainer/TouchHintRestart/MarginContainer/PanelContainer/ButtonRestart

var animal_data: AnimalData

func _ready() -> void:
	animal_data = animal_dataset.pick_random()
	_setup_animal()
	_setup_frame()
	_setup_canvas()
	_setup_controls()

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

func _setup_controls():
	button_back.pressed.connect(_on_button_back_pressed)
	button_restart.pressed.connect(_on_button_restart_pressed)

func _on_canvas_drawn():
	var tween = create_tween()
	tween.tween_property(texture_rect_animal, "modulate:a", 1.0, reveal_duration)
	tween.parallel().tween_property(texture_rect_frame, "modulate:a", 0.0, reveal_duration)
	tween.parallel().tween_property(canvas_container, "modulate:a", 0.0, reveal_duration)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if not _is_in_canvas(event.position):
			touch_hint_back.show_hint()
			touch_hint_restart.show_hint()

func _is_in_canvas(pos: Vector2) -> bool:
	return canvas_container.get_rect().has_point(pos)

func _on_button_back_pressed():
	Events.request_scene.emit(SceneLibraryData.SceneID.TITLE)

func _on_button_restart_pressed():
	Events.request_scene.emit(SceneLibraryData.SceneID.DRAW)
