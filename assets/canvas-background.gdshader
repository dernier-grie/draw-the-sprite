shader_type canvas_item;

uniform vec4 paper_color: source_color = vec4(0.95, 0.95, 0.95, 1.0);
uniform float dot_density: hint_range(200.0, 1000.0) = 500.0;
uniform float grain_intensity: hint_range(0.0, 0.08, 0.01) = 0.04;

float hash(vec2 coords) {
	return fract(sin(dot(coords, vec2(12.9898, 78.233))) * 43758.5453);
}

void fragment() {
	float aspect_ratio = SCREEN_PIXEL_SIZE.y / SCREEN_PIXEL_SIZE.x;
	vec2 fixed_uv = SCREEN_UV;
	fixed_uv.y *= aspect_ratio;
	vec2 grid_uv = fixed_uv * dot_density;
	float noise = hash(floor(grid_uv));
	
	vec3 color = paper_color.rgb - (noise * grain_intensity);
	color *= (1.0 - length(UV - 0.5) * 0.05);
	COLOR = vec4(color, 1.0);
}