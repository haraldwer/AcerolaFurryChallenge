shader_type spatial;

uniform sampler2D Tex; 

uniform float Height;
uniform float ShellHeight = 0.3;
uniform float MinStrandHeight = 0.2;
uniform vec4 BaseColor : source_color = vec4(1.0);
uniform vec4 TipColor : source_color = vec4(1.0);

uniform sampler2D Noise; 
uniform vec2 NoiseScale = vec2(2.0, 0.5);

void vertex() {
	VERTEX += NORMAL * Height * ShellHeight;
}

void fragment() {
	
	float mask = 1.0 - texture(Tex, UV).r;
	if (mask < 0.2)
		discard;
	
	float noise = texture(Noise, UV * NoiseScale).r * mask;
	float strandHeight = MinStrandHeight + (1.0 - MinStrandHeight) * noise;
	float thickness = strandHeight;
	
	float fresnell = pow(clamp(dot(NORMAL, VIEW), 0.0, 1.0), 0.5);
	if (thickness * fresnell < Height)
		discard;
	
	ALBEDO = mix(BaseColor.rgb, TipColor.rgb, noise * Height);
}

void light() {
	vec3 viewForward = mix(vec3(0.0, 0.0, 1.0), VIEW, 0.3);
	vec3 lightDir = mix(viewForward, LIGHT, 0.6);
	float lightDot = clamp(dot(NORMAL, lightDir), 0.0, 1.0);
	float stepLight = step(0.75, lightDot);
	float light = 0.0; //mix(0.0, 0.05, stepLight); 
	
	float stepShadow = step(0.1, lightDot);
	float shadow = mix(0.0, 0.05, stepShadow);
		
	DIFFUSE_LIGHT += (light + shadow) * ATTENUATION * LIGHT_COLOR;
}