shader_type canvas_item;
render_mode unshaded;

uniform sampler2D screen : hint_screen_texture, repeat_disable;
uniform sampler2D gradient: source_color;
uniform sampler2D gradient2: source_color;
uniform float factor1 = 1.0;
uniform float factor2 = 1.0;
uniform float factor3 = 0.0;
uniform float factor4 = 0.0;
uniform float factor5 = 0.0;
uniform float factor6 = 0.0;
uniform float factor7 = 1.0;
uniform float factor8 = 0.0;

void fragment() {
	vec2 iResolution = 1.0 / SCREEN_PIXEL_SIZE;
	vec2 _uv = FRAGCOORD.xy/iResolution.xy;
	vec4 grad_color = texture(gradient,_uv);
	vec4 grad2_color =  texture(gradient2,_uv);
	//Commented row is for watching positional gradient
	//COLOR = grad_color;
	_uv.x *=factor7;
	_uv.x +=factor8;
	COLOR = texture(screen,vec2(_uv.x,((grad_color.x+factor6-factor5)*factor1))+((grad2_color.x+factor3-factor4)*factor2));
}

