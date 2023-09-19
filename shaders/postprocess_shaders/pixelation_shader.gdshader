shader_type canvas_item;
render_mode unshaded;

uniform int pixel_size = 2;
uniform vec4 color: hint;
uniform sampler2D screen : hint_screen_texture, repeat_enable, filter_nearest_mipmap;

void fragment() {
	float x = float(int(FRAGCOORD.x)% pixel_size);
	float y = float(int(FRAGCOORD.y)% pixel_size);
	x = FRAGCOORD.x + floor(float(pixel_size)/2.0)-x;
	y = FRAGCOORD.y + floor(float(pixel_size)/2.0)-y;
	COLOR = texture(screen, vec2(x,y) / (1.0/SCREEN_PIXEL_SIZE));
}
