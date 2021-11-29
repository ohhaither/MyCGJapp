#version 430

uniform mat4 m_pvm;
uniform mat4 m_viewModel;
uniform mat3 m_normal;
out vec4 color;

uniform vec4 l_pos;

in vec4 position;
in vec4 normal;    //por causa do gerador de geometria

out Data {
	vec3 normal;
	vec3 eye;
	vec3 lightDir;
} DataOut;

struct Materials {
	vec4 diffuse;
	vec4 ambient;
	vec4 specular;
	vec4 emissive;
	float shininess;
	int texCount;
};

uniform Materials mat;

void main () {

	vec4 pos = m_viewModel * position;

	DataOut.normal = normalize(m_normal * normal.xyz);
	DataOut.lightDir = vec3(l_pos - pos);
	DataOut.eye = vec3(-pos);

	vec4 spec = vec4(0.0);

	vec3 n = normalize(DataOut.normal);
	vec3 l = normalize(DataOut.lightDir);
	vec3 e = normalize(DataOut.eye);

	float intensity = max(dot(n,l), 0.0);

	
	if (intensity > 0.0) {

		vec3 h = normalize(l + e);
		float intSpec = max(dot(h,n), 0.0);
		spec = mat.specular * pow(intSpec, mat.shininess);
	}

	

	color = max(intensity * mat.diffuse + spec, mat.ambient);


	gl_Position = m_pvm * position;	
}