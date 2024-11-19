#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

float circle(in vec2 _st, in float _radius){
    vec2 l = _st-vec2(0.5);
    return 1.-smoothstep(_radius-(_radius*0.1),
                         _radius+(_radius*0.1),
                         dot(l,l)*10.0);
}

void main() {
	vec2 st = gl_FragCoord.xy/u_resolution;
    vec3 color = vec3(0.0);
    float time = u_time*0.5;
    if( fract(time)>0.33 ){
        st.y *= 3.14*u_time*1.0 / 5.0;
        st *= 5.0;      
        st = fract(st);
    }else{
        st.x *= 3.14*u_time*1.0;
        st *= 5.0;      
        st = fract(st);
    }
    color = vec3(circle(st,0.5));
	gl_FragColor = vec4(color,8.0);
}
