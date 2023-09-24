shader_type canvas_item;
render_mode unshaded;

uniform sampler2D screen : hint_screen_texture, repeat_disable;
uniform sampler2D gradient: source_color;
uniform float translate_screen_uv = 0.9;
uniform float stretch_screen_uv = 0.59;
uniform float translate_position_grad_uv = -1.355;
uniform float stretch_position_grad_uv = 0.19;

void fragment() {
	vec2 iResolution = 1.0 / SCREEN_PIXEL_SIZE;
	vec2 _uv = FRAGCOORD.xy/iResolution.xy;
	vec4 grad_color = texture(gradient,_uv);
	//Commented row is for watching positional gradient
	//COLOR = grad_color;
	_uv.y +=translate_screen_uv;
	_uv.y *=stretch_screen_uv;
	grad_color+=translate_position_grad_uv;
	grad_color*=stretch_position_grad_uv;
	vec4 dist_color = texture(screen,vec2(_uv.x,_uv.y+grad_color.x));
	COLOR = texture(screen,vec2(_uv.x,_uv.y+grad_color.x));
	if(((dist_color.r + dist_color.g +dist_color.b))/3.0<0.18)
		COLOR = vec4(0.0,0.0,0.0,1.0);
}

