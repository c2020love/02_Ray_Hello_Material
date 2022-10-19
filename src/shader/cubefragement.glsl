#version 330 core

struct Materials {
vec3 Enveriment;
vec3 Diffuse;
vec3 Specular;
float shininess;
};

struct LightsK
{
  vec3 postionK;
  vec3 EnverimentK;
  vec3 diffuseK;
  vec3 specularK;
};

uniform LightsK light;

in vec3 Normal;
in vec3 FragPos;
out vec4 FragColor;

uniform Materials material;

uniform vec3 lightPos;
uniform vec3 viewPos;
uniform vec3 objCol;
uniform vec3 lightCol;
void main() {

  //Enveriment
vec3 EnverimentCol = light.EnverimentK * material.Enveriment;

  //Diffuse
vec3 norm = normalize(Normal);

vec3 lightDir = normalize(lightPos - FragPos);

float diff = max(dot(norm, lightDir), 0.0);   //法线向量乘以光照向量
vec3 diffuse = light.diffuseK * (diff * material.Diffuse);                     //计算漫反射分量

  //镜面反射系数
vec3 viewDir = normalize(viewPos -FragPos);    //视线方向分量
vec3 reflectDir = reflect(-lightDir, norm);  //沿着法线的反射向量

  //计算镜面分量
float spec = pow(max(dot(viewDir, reflectDir), 0.0), material.shininess);
vec3 specular = light.specularK * (spec * material.Specular);

  //Result
vec3 resultCol = (EnverimentCol + diffuse + specular) * objCol;  //（环境光+漫反射）*物体原本的颜色

FragColor = vec4(resultCol, 1.0f);

}
