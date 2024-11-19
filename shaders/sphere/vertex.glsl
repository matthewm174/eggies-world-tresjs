uniform vec2 u_amplitude;
uniform vec2 u_frequency;
uniform float u_time;
uniform bool u_flip_a;
uniform bool u_flip_b;
uniform bool u_flip_c;

varying vec2 vUv;

void main() {
    vec4 modelPosition = modelMatrix * vec4(position, 1.0);
    if(u_flip_a){
        modelPosition.x += tan(modelPosition.x * u_frequency.x - u_time) * u_amplitude.x;
        modelPosition.y += sin(modelPosition.y * u_frequency.y - u_time) * u_amplitude.y;
    }
    if(u_flip_b){
        modelPosition.x += cos(modelPosition.x * u_frequency.x - u_time) * u_amplitude.x;
        modelPosition.y += tan(modelPosition.y * u_frequency.y - u_time) * u_amplitude.y;
    }
    if(u_flip_c){
        modelPosition.x += sin(modelPosition.x * u_frequency.x - u_time) * u_amplitude.x;
        modelPosition.y += tan(modelPosition.y * u_frequency.y - u_time) * u_amplitude.y;
    }


    vec4 viewPosition = viewMatrix * modelPosition;
    gl_Position = projectionMatrix * viewPosition;
    vUv = uv;
}