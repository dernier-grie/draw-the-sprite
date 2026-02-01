extends CanvasLayer

@export var particle_scene: PackedScene

func request_star(position: Vector2, color: Color):
	var data = StarParticleData.new()
	data.position = position
	data.amount = 1
	data.color = color
	var particles = particle_scene.instantiate() as StarParticles
	particles.data = data
	add_child(particles)
