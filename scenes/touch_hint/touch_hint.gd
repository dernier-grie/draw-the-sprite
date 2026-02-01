extends Control
class_name TouchHint

@export var auto_hide_time: float = 3.0
@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	timer.wait_time = auto_hide_time
	timer.one_shot = true
	timer.timeout.connect(hide_hint)
	show_hint()

func show_hint() -> void:
	animation_player.play("fade_in")
	timer.start()

func hide_hint() -> void:
	animation_player.play("fade_out")
	
