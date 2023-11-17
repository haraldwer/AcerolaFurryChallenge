shader_type spatial;

uniform vec4 eye_white : source_color = vec4(1.0);
uniform vec4 eye_black : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 eye_iris : source_color = vec4(0.1, 0.1, 0.5, 1.0);

void fragment() {
	vec3 viewDir = VIEW;
	float eyeDot = dot(NORMAL, viewDir);
	vec3 inner_eye = mix(eye_iris.rgb, eye_black.rgb, step(0.8, eyeDot));
	vec3 eye = mix(eye_white.rgb, inner_eye, step(0.6, eyeDot));
	
	ALBEDO = eye;
	EMISSION = eye * 0.4;
}

void light() {
	
	vec3 viewForward = mix(vec3(0.0, 0.0, 1.0), VIEW, 0.3);
	vec3 lightDir = mix(viewForward, LIGHT, 0.6);
	float lightDot = clamp(dot(NORMAL, lightDir), 0.0, 1.0);
	float stepLight = step(0.75, lightDot);
	float light = mix(0.0, 0.1, stepLight); 
	
	SPECULAR_LIGHT += light * ATTENUATION * LIGHT_COLOR;
}