shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

// Controla o quão grossas e fortes são as linhas horizontais
uniform float scanline_count : hint_range(100.0, 1000.0) = 300.0;
uniform float scanline_intensity : hint_range(0.0, 1.0) = 0.5;

// Controla o deslocamento de cor (aquele efeito de "vazamento" nas bordas)
uniform float glitch_amount : hint_range(0.0, 0.01) = 0.002;

void fragment() {
	vec2 uv = UV;
	
	// Efeito de divisão de cores nas bordas (Chromium/Glitch leve)
	float r = texture(SCREEN_TEXTURE, uv + vec2(glitch_amount, 0.0)).r;
	float g = texture(SCREEN_TEXTURE, uv).g;
	float b = texture(SCREEN_TEXTURE, uv - vec2(glitch_amount, 0.0)).b;
	vec4 color = vec4(r, g, b, 1.0);
	
	// Efeito de linhas horizontais bem marcadas (Scanlines)
	float scanline = sin(uv.y * scanline_count * 3.14159) * 0.5 + 0.5;
	color.rgb -= (1.0 - scanline) * scanline_intensity;
	
	COLOR = color;
}