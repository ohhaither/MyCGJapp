#version 430

out vec4 colorOut;
in vec4 color;

struct Materials {
	vec4 diffuse;
	vec4 ambient;
	vec4 specular;
	vec4 emissive;
	float shininess;
	int texCount;
};

uniform Materials mat;

in Data {
	vec3 normal;
	vec3 eye;
	vec3 lightDir;
} DataIn;

void main() {


	
	//colorOut = max(intensity * mat.diffuse + spec, mat.ambient);
	colorOut = color;
}