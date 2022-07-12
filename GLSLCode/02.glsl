
#version 150

uniform float time;
uniform vec2 resolution;
uniform vec2 mouse;
uniform vec3 spectrum;

uniform sampler2D texture0;
uniform sampler2D texture1;
uniform sampler2D texture2;
uniform sampler2D texture3;
uniform sampler2D prevFrame;
uniform sampler2D prevPass;

float circle(vec2 coord, vec2 offs)
{
    float reso = 16.0;
    float cw = resolution.x / reso;

    vec2 p = mod(coord, cw) - cw * 0.5 + offs * cw;

    vec2 p2 = floor(coord / cw) - offs;
    vec2 gr = vec2(0.193, 0.272);
    float tr = time * 2.0;
    float ts = tr + dot(p2, gr);

    float sn = sin(tr), cs = cos(tr);
    p = mat2(cs, -sn, sn, cs) * p;

    float s = cw * (0.3 + 0.3 * sin(ts));
    float d = max(abs(p.x), abs(p.y));

    return max(0.0, 1.0 - abs(s - d));
}

in VertexData
{
    vec4 v_position;
    vec3 v_normal;
    vec2 v_texcoord;
} inData;

out vec4 fragColor;

void main(void)
{
    float c = 0.0;

    for(int i = 0; i < 9; i++) {
        float dx = mod(float(i), 3.0) - 1.0;
        float dy = float(i / 3) - 1.0;
        c += circle(gl_FragCoord.xy, vec2(dx, dy));
    }
    fragColor = vec4(vec3(min(1.0, c)), 1);
}
