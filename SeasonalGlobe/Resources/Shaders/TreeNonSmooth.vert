attribute vec3 aVertex;
attribute vec3 aNormal;

uniform float uShine;
uniform vec4 uDif;
uniform vec4 uSpec;
uniform vec4 uAmb;

uniform vec3 uLightDir;

varying vec4 diffuse;
varying vec4 specular;

void main(void)
{
   gl_Position = gl_ModelViewProjectionMatrix * vec4(aVertex,1.0);

   vec3 vecLight = -uLightDir;
   
   vec3 Pview = vec3(gl_ModelViewMatrix*vec4(aVertex,1.0));

   vec3 norm = normalize(gl_NormalMatrix*aNormal);

   vec3 refl = normalize(2.0 * dot(norm, vecLight) * norm - vecLight);

   vec3 view = -normalize(Pview);

   diffuse = uAmb + uDif * max(0.0, dot(norm, vecLight)); 

   specular = uSpec * pow(max(0.0, dot(refl, view)), uShine);
}