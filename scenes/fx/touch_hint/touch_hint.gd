extends Control
class_name TouchHint

@export var auto_hide_time: float = 3.0

@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var _fully_visible: bool

func _ready() -> void:
	timer.wait_time = auto_hide_time
	timer.one_shot = true
	timer.timeout.connect(_hide_hint)
	show_hint()

func show_hint() -> void:
	if _fully_visible:
		timer.start()
		return

	_fully_visible = true
	if animation_player.current_animation != "fade_in":
		animation_player.play("fade_in")
	timer.start()

func _hide_hint() -> void:
	_fully_visible = false
	animation_player.play("fade_out")
	
