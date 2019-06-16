local Library = require "CoronaLibrary"

-- Create library
local lib = Library:new{ name='materialdesignbuttons', publisherId='io.joehinkle.materialdesignbuttons' }

local widget = require "widget"

local shapes = require "plugin.materialdesignbuttons.shapes"
local shaders = require("plugin.materialdesignbuttons.shaders")
shaders.load()

-------------------------------------------------------------------------------
-- BEGIN (Insert your implementation starting here)
-------------------------------------------------------------------------------

local oldNewButton = widget.newButton
lib.newButton = function( params )
    -- localize button that will be created
    local button

    -- create material click effect canvas
    local effectCanvas = shapes.new( params )
    local shortestSide
    effectCanvas:setFillColor( unpack( params.touchCircleColor or {1} ) )
    effectCanvas.fill.effect = "filter.materialDesignButtons.button"
    effectCanvas.fill.effect.xY = {0,0}
    effectCanvas.fill.effect.circleRadius = 0

    local oldOnRelease = params.onRelease
    local oldOnPress = params.onPress
    local oldOnEvent = params.onEvent
    local effectTransition
    params.onRelease = nil
    params.onPress = nil
    params.onEvent = function( event )
        if ( event.phase == "began" ) then
            transition.cancel(effectCanvas)
            transition.cancel(effectTransition)
            effectCanvas.alpha = 0
            effectCanvas.fill.effect.circleRadius = 0
            local desiredRadius = 200 * 15
            effectTransition = transition.to( effectCanvas.fill.effect, {time=80000,circleRadius=desiredRadius/shortestSide} )
            transition.to( effectCanvas, {time=1000,alpha=.3} )
            local x, y = effectCanvas:contentToLocal( event.x, event.y )
            effectCanvas.startX, effectCanvas.startY = x, y
            effectCanvas.fill.effect.xY = {-x,-y}
            if oldOnPress then oldOnPress( event ) end
        elseif ( event.phase == "moved" ) then
            local x, y = effectCanvas:contentToLocal( event.x, event.y )
            effectCanvas.fill.effect.xY = {-(x + effectCanvas.startX)*.5,-(y + effectCanvas.startY)*.5}
        elseif ( event.phase == "ended" ) then
            transition.cancel( effectCanvas )
            transition.cancel( effectTransition )
            local desiredRadius = 200 * 15
            effectTransition = transition.to( effectCanvas.fill.effect, {time=3000,circleRadius=desiredRadius/shortestSide} )
            transition.to( effectCanvas, {time=30,alpha=.5} )
            transition.to( effectCanvas, {time=30,delay=100,alpha=.3} )
            transition.to( effectCanvas, {time=300,delay=300,alpha=0} )
            if oldOnRelease then oldOnRelease( event ) end
        elseif ( event.phase == "cancelled" ) then
            transition.cancel( effectCanvas )
            transition.cancel( effectTransition )
            transition.to( effectCanvas, {time=300,alpha=0} )
        end
        if oldOnEvent then oldOnEvent( event ) end
    end

	-- create button with params using Corona's default API
	button = oldNewButton( params )

    -- put canvas in button
    effectCanvas.x = button.width*.5
    effectCanvas.y = button.height*.5
    effectCanvas.fill.effect.widthHeight = {button.width,button.height}
    shortestSide = math.min(button.width,button.height)
    button:insert( effectCanvas )

    -- prevent shadows from causing touch
    button:removeEventListener( "touch" )
    local shape = button[1]
    shape:addEventListener( "touch", function( event )
        button.touch( button, event )
    end )

	-- create shadows based on the result of the button creation
	if not params.hideShadow then
		params.width  = button.width
		params.height = button.height
		local shadow1 = shapes.shadow( params )
		local shadow2 = shapes.shadow( params )
		if shadow1 and shadow2 then
			-- if shadows were created, then put them inside the button
			shadow1.x = button.width*.5
			shadow1.y = button.height*.5
			shadow2.x = button.width*.5
			shadow2.y = button.height*.5
			button:insert(shadow1)
			shadow1:toBack()
			button:insert(shadow2)
			shadow2:toBack()

			-- position shadows based on the given z position of the button by intercepting the setting of z
            local oldMetatable = getmetatable(button)
            local oldIndex     = oldMetatable.__index
            local oldNewIndex  = oldMetatable.__newindex
            local rawZ         = 0
			setmetatable( button, {
				__index = function( myTable, key )
					if key == "z" then
                        return rawZ
                    elseif key == "contentBounds" then
                        return shape.contentBounds
                    else
						return oldIndex( myTable, key )
					end
				end,
				__newindex = function( myTable, key, value )
					if key == "z" then
						print("z set to: "..tostring(value))
						rawZ = math.min(7,math.max(value,0))
			            if rawZ ~= value then
			                print( "Warning: material design buttons can only have a z value from 0 to 7. You tried to set the z value to "..value )
			            end

		                shadow1.xScale = ((1 + rawZ*.035) + myTable.xScale)*.5
		                shadow1.yScale = ((1 + rawZ*.035) + myTable.xScale)*.5
		                shadow2.xScale = ((1 + rawZ*.035) + myTable.xScale)*.5
		                shadow2.yScale = ((1 + rawZ*.035) + myTable.xScale)*.5

		                shadow1.child:setFillColor( 0,0,0,.2+rawZ*.01)
		                shadow1.xScale = .8 + rawZ*.05
		                shadow1.yScale = .8 + rawZ*.05

		                shadow2.child:setFillColor( 0,0,0,.4+rawZ*.05 )
                        shadow2.xScale   = .8 + rawZ*.05
                        shadow2.yScale   = .8 + rawZ*.05
                        shadow2.child.y  = 5.3
					else
						oldNewIndex( myTable, key, value )
					end
				end
			} )
			button.z = params.z or 0
		end
	end
	return button
end

lib.initHooks = function()
	widget.newButton = lib.newButton
end
-------------------------------------------------------------------------------
-- END
-------------------------------------------------------------------------------

-- Return library instance
return lib
