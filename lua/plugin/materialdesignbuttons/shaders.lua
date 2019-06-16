local shaders = {}

function shaders.load()
	local kernel = {}
	kernel.category = "filter"
	kernel.group = "coronaMaterial"
	kernel.name = "button"
	 
	kernel.fragment =
	[[
	uniform P_POSITION vec2 u_UserData0; // widthHeight
	uniform P_POSITION vec2 u_UserData1; // xY
	uniform P_POSITION float u_UserData2; // circleRadius // line 78?
	//uniform P_UV mat3 u_UserData3; // uvs
	// ^^ This is subject to change!!!
	// source: https://forums.coronalabs.com/topic/72174-uniform-userdata-in-custom-shader/

	P_COLOR vec4 FragmentKernel( P_UV vec2 texCoord )
	{
	    P_COLOR vec4 texColor = texture2D( CoronaSampler0, texCoord );

	    P_DEFAULT float size = u_UserData2; // 0 = gone, 1 = fits

	    P_DEFAULT float ratio = (u_UserData0.x/u_UserData0.y)*(u_UserData0.x/u_UserData0.y);

	    P_DEFAULT float offsetX = u_UserData1.x/u_UserData0.x;
	    P_DEFAULT float offsetY = u_UserData1.y/u_UserData0.y;

	    P_DEFAULT float x = (texCoord.x-.5+offsetX);// * CoronaTexelSize.xy.x; // uncomment that other part if there is odd mis-scaling to take into account ()
	    P_DEFAULT float y = (texCoord.y-.5+offsetY);// * (CoronaTexelSize.xy.y+1); // uncomment that other part if there is odd mis-scaling to take into account ()

	    if (ratio >= 1.0) {
			if ( (x*x*ratio) + (y*y) >= .25*size*size ) {
				texColor.rgba *= 0.0;
			}
		} else {
			if ( (x*x) + (y*y/ratio) >= .25*size*size ) {
				texColor.rgba *= 0.0;
			}
		}
		//texColor.rgba *= .9-((1-size)*(1-size)*.01);
	 
	    // Modulate by the display object's combined alpha/tint
	    return CoronaColorScale( texColor );
	}
	]]
	kernel.uniformData = {
		{
			index = 0, name = "widthHeight", min = {0,0}, max = {10000,10000}, default = {100,100}, type = "vec2"
		}, {
			index = 1, name = "xY", min = {-10000,-10000}, max = {10000,10000}, default = {0,0}, type = "vec2"
		}, {
			index = 2, name = "circleRadius", min = 0, max = 10000, default = 0, type = "float"
		-- }, {
		-- 	index = 3, name = "uv", min = uv0, max = K(9, 1), default = uv0, type = "mat3"
		}
	}
	graphics.defineEffect( kernel )
end

return shaders