precision highp float;
varying vec2 v_texcoord;
uniform sampler2D tex;

void main() {
    vec4 color = texture2D(tex, v_texcoord);
    
    // Vážený průměr podle vnímání jasu (HDTV standard)
    float gray = dot(color.rgb, vec3(0.2126, 0.7152, 0.0722));
    
    gl_FragColor = vec4(vec3(gray), color.a);
}
