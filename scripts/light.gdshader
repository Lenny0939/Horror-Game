shader_type canvas_item;


uniform sampler2D screen_texture : hint_screen_texture, filter_nearest;
uniform vec2 lights[100];
uniform int number_of_lights = 1;
uniform vec4 modulate_color : source_color = vec4 (0.0);
uniform vec2 player_vector;

float angle_from_light(vec2 coords) {
	float angle = 1000.0;

	for (int i = 0; i < number_of_lights; i++) {
		float new_angle = degrees(acos(dot(normalize(coords - lights[i]), vec2(1, 0))));
		if(new_angle < angle) {
			angle = new_angle;
		}
	}

	return angle;
}

void fragment() {
	COLOR = texture(screen_texture, SCREEN_UV);
	float angle = angle_from_light(FRAGCOORD.xy);
	float player_angle = degrees(acos(dot(normalize(player_vector), FRAGCOORD.xy)));

	if (angle < player_angle - 15.0 || angle > player_angle + 15.0)
		COLOR = COLOR * modulate_color;
}