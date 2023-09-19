shader_type canvas_item;
render_mode unshaded;

uniform sampler2D screen : hint_screen_texture, repeat_enable, filter_nearest_mipmap;
uniform float speed = 2;

void fragment() {
	vec2 iResolution = 1.0 / SCREEN_PIXEL_SIZE;
	vec2 uv = FRAGCOORD.xy/iResolution.xy;
    float time = TIME*speed;
    float f = 1.-floor(time)*4.+(1.-uv.y)*300.;
    f = clamp (f,0.,1.);
    COLOR = texture(screen, uv );
    float f2 = (fract(time)>uv.x)?1.:0.;
    vec4 rowColor = mix(vec4(0.), COLOR, f2);
    COLOR = mix(COLOR, rowColor, f);

    f = 1.-floor(time+1.)*4.+(1.-uv.y)*300.;
    f = clamp (f,0.,1.);

    COLOR = mix(COLOR, vec4(0.), f);
}
