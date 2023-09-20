shader_type canvas_item;
render_mode unshaded;
uniform sampler2D screen : hint_screen_texture, repeat_enable, filter_nearest_mipmap;
uniform sampler2D meme_foreground: source_color;
uniform sampler2D meme_background: source_color;
uniform float speed = 2;

void fragment() {
	vec2 iResolution = 1.0 / SCREEN_PIXEL_SIZE;
	vec2 uv = FRAGCOORD.xy/iResolution.xy;
    float time = TIME*speed;
    vec4 color_background = texture(meme_background, uv);
	vec4 color_foreground = texture(meme_foreground, uv);
	COLOR = mix(color_background,color_foreground,time);
	}
	
/*Original GLSL
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