shader_type canvas_item;

uniform vec4 shade_color : source_color = vec4(0.0, 0.0, 0.0, 0.3);

void fragment() {
    COLOR = mix(COLOR, shade_color, shade_color.a);
}