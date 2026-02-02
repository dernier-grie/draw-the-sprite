extends Node

@onready var title_area: Control = $MarginContainer/TitleArea
@onready var touch_hint: TouchHint = $TouchHint

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if _is_in_title_area(event.position):
			Events.request_scene.emit(SceneLibraryData.SceneID.DRAW)
		else:
			touch_hint.show_hint()

func _is_in_title_area(pos: Vector2) -> bool:
	return title_area.get_rect().has_point(pos)
