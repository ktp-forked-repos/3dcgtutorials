#version 150 compatibility
#extension GL_ARB_texture_rectangle : enable
uniform sampler2DRect instanceMatrixTexture;

smooth out vec2 texCoord;
smooth out vec3 normal;
smooth out vec3 lightDir;

void main()
{
	vec2 instanceCoord = vec2((gl_InstanceID % 4096) * 4.0, gl_InstanceID / 4096);
	mat4 instanceModelMatrix = mat4(texture2DRect(instanceMatrixTexture, instanceCoord),
									texture2DRect(instanceMatrixTexture, instanceCoord + vec2(1.0, 0.0)),
									texture2DRect(instanceMatrixTexture, instanceCoord + vec2(2.0, 0.0)),
									texture2DRect(instanceMatrixTexture, instanceCoord + vec2(3.0, 0.0)));

	gl_Position = gl_ModelViewProjectionMatrix * instanceModelMatrix * gl_Vertex;
	texCoord = gl_MultiTexCoord0.xy;

	mat3 normalMatrix = mat3(instanceModelMatrix[0][0], instanceModelMatrix[0][1], instanceModelMatrix[0][2],
							 instanceModelMatrix[1][0], instanceModelMatrix[1][1], instanceModelMatrix[1][2],
							 instanceModelMatrix[2][0], instanceModelMatrix[2][1], instanceModelMatrix[2][2]);

	normal = gl_NormalMatrix * normalMatrix * gl_Normal;
	lightDir = gl_LightSource[0].position.xyz;
}