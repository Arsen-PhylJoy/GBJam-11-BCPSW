shader_type canvas_item;
render_mode unshaded;
uniform vec4 background_color: source_color;
uniform sampler2D screen : hint_screen_texture, repeat_enable, filter_nearest_mipmap;
uniform bool start = false;
uniform float frame = 82;
//80's frame is start
//122's frame is end
void fragment() {
	float speed = 85.0;
	if(start == false)
	//leave screen the same
		COLOR = texture(screen, SCREEN_UV);
	//2 lines here are to get rid of resolution problems
	vec2 iResolution = 1.0 / SCREEN_PIXEL_SIZE;
	vec2 uv = -FRAGCOORD.xy/iResolution.xy;
    float f = 1.-floor(frame)*4.+(1.-uv.y)*300.0;
    f = 1.0/clamp (f,0.,1.);
    vec4 col = texture(screen, uv);
    float f2 = (fract(frame)<uv.x)?1.:0.;
    vec4 rowColor = mix(vec4(0.), background_color, f2);
    COLOR = mix(COLOR, rowColor, f);

    f = 1.-floor(frame+1.)*4.+(1.-uv.y)*300.0;
    f = clamp (f,0.,1.);

    COLOR = mix(COLOR, background_color, f);
}
/*
const float speed = 2.;

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord.xy/iResolution.xy;
    float time = iTime*speed;
    float f = 1.-floor(time)*4.+(1.-uv.y)*300.;
    f = clamp (f,0.,1.);
    fragColor = texture(iChannel0, uv );
    float f2 = (fract(time)>uv.x)?1.:0.;
    vec4 rowColor = mix(vec4(0.), fragColor, f2);
    fragColor = mix(fragColor, rowColor, f);

    f = 1.-floor(time+1.)*4.+(1.-uv.y)*300.;
    f = clamp (f,0.,1.);

    fragColor = mix(fragColor, vec4(0.), f);
}

*/
