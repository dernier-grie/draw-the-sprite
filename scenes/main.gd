extends Node

@export var animal_data: AnimalData
@export var canvas_scene: PackedScene

@onready var canvas_container: Node = $CanvasContainer

func _ready() -> void:
	for child in canvas_container.get_children():
		child.queue_free()
	var canvas = canvas_scene.instantiate() as DrawCanvas
	canvas.points = animal_data.points
	canvas.frame_size = animal_data.texture.get_width()
	canvas_container.add_child(canvas)
