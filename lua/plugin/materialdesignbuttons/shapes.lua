local shapes = {}

function shapes.new( args )
	if args.shape == "rect" or args.shape == "roundedRect" then
		return display.newRoundedRect( 0, 0, args.width, args.height, args.cornerRadius )
	elseif args.shape == "circle" then
		local circle = display.newCircle( 0, 0, args.width*.5 )
		circle.height = args.height
		return circle
	end
end
function shapes.shadow( args )
	if args.shape == "rect" or args.shape == "roundedRect" then
		local rect
		if args.noFade then
			rect = display.newImageRect( "plugin/materialdesignbuttons/shadow_nofade.png", args.width*2, args.height*2 )
		else
			rect = display.newImageRect( "plugin/materialdesignbuttons/shadow.png", args.width*2, args.height*2 )
		end
		return rect
	elseif args.shape == "circle" then
		local circle
		if args.noFade then
			circle = display.newImageRect( "plugin/materialdesignbuttons/shadowcirc_nofade.png", args.width*2, args.height*2 )
		else
			circle = display.newImageRect( "plugin/materialdesignbuttons/shadowcirc.png", args.width*2, args.height*2 )
		end
		-- circle.yScale = args.height/args.width
		return circle
	end
end



return shapes