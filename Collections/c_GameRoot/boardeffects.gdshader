#ifdef GL_ES
precision highp float;
#endif

// Slightly modified, but sauce: https://github.com/MrEliptik/godot_ui_components/blob/main/scenes/balatro/shaders/oil.gdshader

shader_type canvas_item;
uniform sampler2D oil_tint_gradient;
uniform float oil_opacity:hint_range(0.01, 1.0, 0.05) = 1.0;
uniform float oil_speed:hint_range(0.5, 32.0, 0.1) = 10.0;
uniform float oil_zoom:hint_range(0.25, 32.0, 0.1) = 5.0;
uniform float oil_brighness:hint_range(0.0, 3.0, 0.1) = 1.0;
uniform float oil_contrast:hint_range(0.0, 3.0, 0.1) = 1.0;

const mat2 mtx = mat2(vec2(0.80,  0.60), vec2(-0.60,  0.80));

float colormap_red(float x) {
    if (x < 0.0) {
        return 54.0 / 255.0;
    } else if (x < 20049.0 / 82979.0) {
        return (829.79 * x + 54.51) / 255.0;
    } else {
        return 1.0;
    }
}

float colormap_green(float x) {
    if (x < 20049.0 / 82979.0) {
        return 0.0;
    } else if (x < 327013.0 / 810990.0) {
        return (8546482679670.0 / 10875673217.0 * x - 2064961390770.0 / 10875673217.0) / 255.0;
    } else if (x <= 1.0) {
        return (103806720.0 / 483977.0 * x + 19607415.0 / 483977.0) / 255.0;
    } else {
        return 1.0;
    }
}

float colormap_blue(float x) {
    if (x < 0.0) {
        return 54.0 / 255.0;
    } else if (x < 7249.0 / 82979.0) {
        return (829.79 * x + 54.51) / 255.0;
    } else if (x < 20049.0 / 82979.0) {
        return 127.0 / 255.0;
    } else if (x < 327013.0 / 810990.0) {
        return (792.02249341361393720147485376583 * x - 64.364790735602331034989206222672) / 255.0;
    } else {
        return 1.0;
    }
}

vec4 colormap(float x) {
    return vec4(colormap_red(x),
		colormap_green(x),
		colormap_blue(x),
		1.0);
}

vec3 gray(vec3 color)
{
	return vec3((color.r + color.g + color.b) / 3.0);
}

vec3 get_gradient_color(float position){
	return texture(oil_tint_gradient, vec2(position, 0.5)).rgb;
}

vec4 tinted_color_map(float x){
	return vec4(
		get_gradient_color(
			gray(
				vec3(
					colormap_red(x),
					colormap_green(x),
					colormap_blue(x)
				)
			).r
		),
		1.0);
}

float rand(vec2 n) {
    return fract(sin(dot(n, vec2(12.9898, 4.1414))) * 43758.5453);
}

float noise(vec2 p){
    vec2 ip = floor(p);
    vec2 u = fract(p);
    u = u*u*(3.0-2.0*u);

    float res = mix(
        mix(rand(ip),rand(ip+vec2(1.0,0.0)),u.x),
        mix(rand(ip+vec2(0.0,1.0)),rand(ip+vec2(1.0,1.0)),u.x),u.y);
    return res*res;
}

float fbm( vec2 p )
{
    float f = 0.0;

    f += 0.500000*noise( p + TIME / (oil_speed) ); p = mtx*p*2.02;
    f += 0.031250*noise( p ); p = mtx*p*2.01;
    f += 0.250000*noise( p ); p = mtx*p*2.03;
    f += 0.125000*noise( p ); p = mtx*p*2.01;
    f += 0.062500*noise( p ); p = mtx*p*2.04;
    f += 0.015625*noise( p + sin(TIME / (oil_speed)) );

    return f/0.96875;
}

float pattern( in vec2 p )
{
	return fbm( p + fbm( p + fbm( p ) ) );
}

void mainImage( out vec4 fragColor, in vec2 uv, in bool tint)
{
	//vec2 uv = fragCoord/resolution.x;
	float shade = pattern(uv * oil_zoom) * oil_contrast;
	fragColor = (!tint ? vec4(colormap(shade).rgb, 1.0) : vec4(tinted_color_map(shade).rgb, 1.0)) * vec4(vec3(oil_brighness), 1.0);
	fragColor.a = oil_opacity;
}


void fragment()
{
	mainImage(COLOR, SCREEN_UV, true);
}
