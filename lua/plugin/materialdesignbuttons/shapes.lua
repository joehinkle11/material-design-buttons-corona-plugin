local shapes = {}

function shapes.shadow( args )
	if args.shape == "rect" or args.shape == "roundedRect" then
		local rect
		local group = display.newGroup()
		if args.noFade then
			rect = display.newImageRect( "plugin/materialdesignbuttons/shadow_nofade.png", args.width*2, args.height*2 )
		else
			rect = display.newImageRect( "plugin/materialdesignbuttons/shadow.png", args.width*2, args.height*2 )
		end
		group.child = rect
		group:insert(group.child)
		return group
	elseif args.shape == "circle" then
		local circle
		local group = display.newGroup()
		if args.noFade then
			circle = display.newImageRect( "plugin/materialdesignbuttons/shadowcirc_nofade.png", args.width*2, args.height*2 )
		else
			circle = display.newImageRect( "plugin/materialdesignbuttons/shadowcirc.png", args.width*2, args.height*2 )
		end
		-- circle.yScale = args.height/args.width
		group.child = circle
		group:insert(group.child)
		return group
	end
end



return shapes