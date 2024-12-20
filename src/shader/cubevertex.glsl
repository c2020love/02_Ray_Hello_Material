#version 330 core
    layout (location = 0) in vec3 aPos;
    layout (location = 1) in vec3 aNormal; //法向量

    uniform mat4 model;
    uniform mat4 view;
    uniform mat4 project;

    out vec3 Normal;
    out vec3 FragPos;
    void main()
    {
      gl_Position = project*view*model*vec4(aPos,1.0f);
      FragPos = vec3(model*vec4(aPos,1.0f));
      Normal = mat3(transpose(inverse(model)))*aNormal;
    }
