shader_type canvas_item;
render_mode unshaded;
uniform vec4 background_color: source_color;
uniform sampler2D screen : hint_screen_texture, repeat_enable, filter_nearest_mipmap;
uniform float row_fatness = 12.0;
uniform float speed = 19.0;
uniform float time = -0.01;
uniform bool fade = true;

void fragment() {
	vec2 iResolution = 1.0 / SCREEN_PIXEL_SIZE;
    vec2 uv = FRAGCOORD.xy/iResolution.xy;
    float f = 1.-floor(time)*row_fatness+(1.-uv.y)*300.0;
    f = clamp (f,0.,1.);
	COLOR = texture(screen, uv );
    float f2 = (fract(time)<uv.x)?1.0:0.0;
    vec4 rowColor = mix(vec4(0.), background_color,f2);
	if(fade == true)
		COLOR = mix(rowColor, COLOR, f);
	else
    	COLOR = mix(COLOR, rowColor, f);
    f = 1.-floor(time+1.)*row_fatness+(1.-uv.y)*300.0;
    f = clamp (f,0.,1.);
	if(fade == true)
		COLOR = mix(background_color, COLOR, f);
	else
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
