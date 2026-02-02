extends CanvasLayer
class_name AudioCueLayer

@export var rect: Rect2
@export var audio_cue_label_scene: PackedScene

func _ready() -> void:
	rect = get_viewport().get_visible_rect()

func spawn_audio_cues(text: String, count: int):
	for i in range(count):
		var audio_cue_label = audio_cue_label_scene.instantiate() as AudioCueLabel
		audio_cue_label.audio_text = text
		audio_cue_label.start_position = Vector2(randf_range(rect.position.x, rect.end.x), randf_range(rect.position.y, rect.end.y))
		add_child(audio_cue_label)
