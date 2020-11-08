#version 330 compatibility

uniform float	uTime;		// "Time", from Animate( )
uniform float	uRadius;
uniform int		uV1;		
uniform int		uV2;		
uniform int		uC1;		

out		vec4	myColor;
out vec2  	vST;		// texture coords

const float PI = 	3.14159265;
const float AMP = 	0.2;		// amplitude
const float W = 	2.;		// frequency

out  vec3  vN;		// normal vector
out  vec3  vL;		// vector from point to light
out  vec3  vE;		// vector from point to eye

void
main( )
{ 
	vST = gl_MultiTexCoord0.st;
	int uLoop;
	float uT;
	float gap = 1. / 3.;
	if (uTime < gap)
	{
		uT = uTime * 3.;
	}
	else if (uTime < (2. * gap))
	{
		uT = (uTime - gap) * 3.;
		
	}
	else
		uT = (uTime - 2. * gap) * 3.;
	vec3 vert = gl_Vertex.xyz;
	float zone = uRadius / 5.;
	float top =  uRadius - (uRadius * 2. + zone) * uT;
	float bot = top + zone;
	float diff = 0.1;
	float yy = (uRadius - vert.y) / (uRadius * 2.);
	if (vert.y > top && vert.y < bot && vert.x != 0.)
	{	
		float vx = vert.x;
		float vz = vert.z;
		vec3 direction = vec3(vx , 0., vz);
		vert = vert + (direction * diff);
		if (uTime < gap)
		{
			myColor = vec4(1., 0., 0., 1.);
		}
		else if (uTime < (2. * gap))
		{
			myColor = vec4(0., 1., 0., 1.);
		}
		else
			myColor = vec4(0., 0., 1., 1.);
	}
	else if (vert.y > top)
	{
		if (uTime < gap)
		{
			myColor = vec4(1., 0., 0., 1.);
		}
		else if (uTime < (2. * gap))
		{
			myColor = vec4(0., 1., 0., 1.);
		}
		else
			myColor = vec4(0., 0., 1., 1.);
			
	}
	else 
	{
		if (uTime < gap)
		{
			myColor = vec4(0., 0., 1., 1.);
		}
		else if (uTime < (2. * gap))
		{
			myColor = vec4(1., 0., 0., 1.);
		}
		else
			myColor = vec4(0., 1., 0., 1.);
	}
	
	vec3 LightPosition = vec3(0., 5., 0.);
	vec4 ECposition = gl_ModelViewMatrix * gl_Vertex;

	vN = normalize( gl_NormalMatrix * gl_Normal );	// normal vector
	vL = LightPosition - ECposition.xyz;		// vector from the point
							// to the light position
	vE = vec3( 0., 0., 0. ) - ECposition.xyz;	// vector from the point
							// to the eye position


	if (uV1 == 1)
	{
		gl_Position = gl_ModelViewProjectionMatrix * vec4( vert, 1. );
	}
	else
	{
		gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;	
	}

	if (uC1 == 1)
	{
	
	}
	else
	{
		myColor = vec4(1., 1., 1., 1.);
	}


}
