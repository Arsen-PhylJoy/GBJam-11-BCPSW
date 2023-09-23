shader_type canvas_item;

uniform vec4 color1: source_color;
uniform vec4 color2: source_color;
uniform vec4 color3: source_color;
uniform vec4 color4: source_color;
uniform bool simple_shading_mode = true;
uniform float brightness_factor = 0.0;
uniform sampler2D screen : hint_screen_texture, repeat_disable;

void fragment() {
	vec4 result_color;
	bool stop_calculating = false;
	vec4 current_color = texture(screen, SCREEN_UV);
	if(		current_color == color1 || current_color == color2 ||
			current_color == color3 || current_color == color4){
		COLOR = current_color;
		stop_calculating = true;
	}
	else if(simple_shading_mode == true && stop_calculating == false){
		float average_color = (current_color.r+current_color.g+current_color.b)/3.0;
		if(average_color>0.15+brightness_factor)
			result_color = color1;
		if(average_color > 0.25+brightness_factor)
			result_color = color2;
		if(average_color > 0.55+brightness_factor)
			result_color = color3;
		if(average_color > 0.75+brightness_factor)
			result_color = color4;
		COLOR = result_color;
	}
	else{
		float distance_to_color[4];
		distance_to_color[0] = sqrt(pow(color1.r - current_color.r,2) +
									pow(color1.g - current_color.g,2) +
									pow(color1.b - current_color.b,2));
		distance_to_color[1] = sqrt(pow(color2.r - current_color.r,2) +
									pow(color2.g - current_color.g,2) +
									pow(color2.b - current_color.b,2));
		distance_to_color[2] = sqrt(pow(color3.r - current_color.r,2) +
									pow(color3.g - current_color.g,2) +
									pow(color3.b - current_color.b,2));
		distance_to_color[3] = sqrt(pow(color4.r - current_color.r,2) +
									pow(color4.g - current_color.g,2) +
									pow(color4.b - current_color.b,2));
		float minimum = distance_to_color[0];
		int res_index_color = 0;
		for(int i =0;i<3;i++)
			if(minimum>distance_to_color[i])
				res_index_color = i;
		if(res_index_color == 0)
			COLOR = color1;
		else if(res_index_color == 1)
			COLOR = color2;
		else if(res_index_color == 2)
			COLOR = color3;
		else if(res_index_color == 3)
			COLOR = color4;
	}
}
