extends Node

@export var scene_library: SceneLibraryData
@onready var scene_container: Node = $SceneContainer
@onready var animation_player_overlay: AnimationPlayer = $CanvasLayer/ColorRect/AnimationPlayer

func _ready() -> void:
	for child in scene_container.get_children():
		child.queue_free()
	var title_scene = scene_library.get_scene(SceneLibraryData.SceneID.TITLE)
	scene_container.add_child(title_scene.instantiate())
	
func transition_to(id: SceneLibraryData.SceneID) -> void:
	animation_player_overlay.play("fade-in")
	await animation_player_overlay.animation_finished
	
	for child in scene_container.get_children():
		child.queue_free()
	var scene = scene_library.get_scene(id).instantiate()
	scene_container.add_child(scene)

	animation_player_overlay.play("fade-out")
