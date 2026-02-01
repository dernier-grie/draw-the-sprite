extends GPUParticles2D
class_name StarParticles

@export var data: StarParticleData = StarParticleData.new()

func _ready() -> void:
	emitting = true
	global_position = data.position
	amount = data.amount
	modulate = data.color
	finished.connect(queue_free)
