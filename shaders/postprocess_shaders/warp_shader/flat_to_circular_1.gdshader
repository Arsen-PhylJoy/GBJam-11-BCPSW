shader_type canvas_item;
render_mode unshaded;
uniform float param1= -1.275;
uniform float param2= -0.96;
uniform float y_translate = 1.295;
uniform sampler2D screen : hint_screen_texture, repeat_disable;

void fragment() {
	vec2 iResolution = 1.0 / SCREEN_PIXEL_SIZE;
	vec2 _uv = FRAGCOORD.xy/iResolution.xy * 2.0 - 1.0;
	_uv.y = -_uv.y;
	_uv.y+=y_translate;
	_uv.x *= iResolution.x / iResolution.y;
	//Calculate gradient position
	float d = 1.0/length(_uv);
	d+=param1;
	d*=param2;
	vec4 grad_position = vec4(1.0-d,d,d,1.0);
	//Commented row is for watching positional gradient
	//COLOR = grad_position;
	COLOR = texture(screen,vec2(SCREEN_UV.x,grad_position.x));
}

