#version 330 compatibility

uniform float	uTime;		// "Time", from Animate( )
//uniform float   uKa, uKd, uKs;		// coefficients of each type of lighting
//uniform vec3  uColor;			// object color
//uniform vec3  uSpecularColor;		// light color
//uniform float uShininess;		// specular exponent
uniform	  int	uV2;
in  vec2  vST;			// texture coords
in  vec3  vN;			// normal vector
in  vec3  vL;			// vector from point to light
in  vec3  vE;			// vector from point to eye
in vec4		myColor;

void
main( )
{
	
	float slice = uTime;
	int i;
	
	if (uV2 == 1)
	{
		for(i = 0; i < 10; i++)
		{
			slice += 0.1;

			if (slice > 1.)
			{
				slice = slice - 1.;
			}

			if (vST.s > slice  && vST.s < (slice + 0.01))
			{
				discard;
			}

			if (vST.t > slice  && vST.t < (slice + 0.01))
			{
				discard;
			}
		}
	}
	else
	{
	
	}
	
	vec3 Normal = normalize(vN);
	vec3 Light  = normalize(vL);
	vec3 Eye    = normalize(vE);
	float uKa = 0.8;
	float uKd = 0.1;
	float uKs = 0.1;
	vec3 uColor = myColor.xyz;
	vec3 uSpecularColor = vec3(1., 1., 1.);
	float uShininess = 120.;

	vec3 ambient = uKa * myColor.xyz;

	float d = max( dot(Normal,Light), 0. );       // only do diffuse if the light can see the point
	vec3 diffuse = uKd * d * myColor.xyz;

	float s = 0.;
	if( dot(Normal,Light) > 0. )	          // only do specular if the light can see the point
	{
		vec3 ref = normalize(  reflect( -Light, Normal )  );
		s = pow( max( dot(Eye,ref),0. ), uShininess );
	}
	vec3 specular = uKs * s * uSpecularColor;
	gl_FragColor = vec4( ambient + diffuse + specular,  1. );	

}
