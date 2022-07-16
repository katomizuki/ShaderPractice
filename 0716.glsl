precision mediump float;
uniform vec2  m;       // mouse
uniform float t;       // time
uniform vec2  r;       // resolution
uniform sampler2D smp; // prev scene

vec3 hsv(float h, float s, float v){
    vec4 t = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(vec3(h) + t.xyz) * 6.0 - vec3(t.w));
    return v * mix(vec3(t.x), clamp(p - vec3(t.x), 0.0, 1.0), s);
}

void main(void){
vec2 p = (gl_FragCoord.xy * 2.0 - r) / min(r.x, r.y);
    vec3 destColor = vec3(0.5, 0.3, 0.7);
    float f = 0.0;
    for(float i = 0.0; i < 10.0; i++){
        float s = sin(t + i * 0.628318) * 0.5;
        float c = cos(t + i * 0.628318) * 0.5;
        f += 0.05 / abs(length(p + vec2(c, s)) - 0.5);
    }
    gl_FragColor = vec4(vec3(destColor * f), 1.0);
}

