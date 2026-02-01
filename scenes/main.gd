extends Node

@export var scene_library: SceneLibraryData
@onready var scene_container: Node = $SceneContainer

func _ready() -> void:
	change_to(scene_library.draw_screen)
	
func change_to(target_scene: PackedScene):
	for child in scene_container.get_children():
		child.queue_free()
	var scene = target_scene.instantiate()
	scene_container.add_child(scene)
