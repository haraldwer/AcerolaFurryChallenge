shader_type spatial;

uniform vec4 skin_color : source_color = vec4(0.5, 0.5, 0.5, 1.0);

void fragment() {
	
	ALBEDO = skin_color.rgb;
	EMISSION = skin_color.rgb * 0.1;
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