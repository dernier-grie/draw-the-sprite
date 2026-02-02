extends Label
class_name AudioCueLabel

@export_group("Label")
@export var audio_text: String
@export var start_position: Vector2

@export_group("Animation")
@export_range(0.1, 1.0, 0.1) var speed_scale: float = 1.0
@export var max_delay: float = 1.0

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	text = audio_text
	hide()
	await get_tree().process_frame
	global_position = start_position - size / 2
	await get_tree().create_timer(randf_range(0.0, max_delay)).timeout
	animation_player.play("fade_in_out")
	await animation_player.animation_finished
	queue_free()
