extends Node

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		Events.request_scene.emit(SceneLibraryData.SceneID.DRAW)
