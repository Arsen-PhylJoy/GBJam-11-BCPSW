//Some strange shader 

shader_type canvas_item;
render_mode unshaded;
uniform float translate_x = 1;
uniform float translate_y = 1;
uniform float factor = 1;
uniform sampler2D screen : hint_screen_texture, repeat_enable, filter_nearest_mipmap;


void fragment() {
	vec4 col1;
	vec4 col2;
	float option = 0.;
	vec2 iResolution = 1.0 / SCREEN_PIXEL_SIZE;
	vec2 uv = FRAGCOORD.xy/iResolution.xy * 2.0 - factor;
	uv*=factor;
	uv.x+= translate_x;
	uv.y+= translate_y;
	if(uv.y > 0.898984745 && texture(screen, uv) == vec4(1.0,1.0,1.0,1.0))
	{
		col2 = texture(screen,uv);
		option = 1.;
	}
	uv = vec2(0.5,0.5) - uv;
	uv.xy = vec2(uv.y,-uv.x);
	col1 = texture(screen, vec2((atan(uv.y,uv.x) / PI + 1.0) / 2.0, 1.0- sqrt(uv.x * uv.x + uv.y * uv.y) * 1.8));
	if(option == 0.)
		COLOR = col1;
	else if(option == 1.)
		COLOR = col2;
}