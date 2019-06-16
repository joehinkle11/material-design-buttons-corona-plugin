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
    -- create material click effect canvas
    local effectCanvas = shapes.new( params )
    effectCanvas:setFillColor( unpack( params.touchCircleColor or {1} ) )
    effectCanvas.fill.effect = "filter.materialDesignButtons.button"
    effectCanvas.fill.effect.xY = {0,0}
    effectCanvas.fill.effect.circleRadius = 0

    -- -- animate effect
    local effectTransition
    local oldOnEvent = params.onEvent
    params.onEvent = function( event )
        effectCanvas.fill.effect.circleRadius = 1
        if oldOnEvent then oldOnEvent( event ) end
    end

	-- create button with params using Corona's default API
	local button = oldNewButton( params )

    -- put the effect into the button
    effectCanvas.x = button.width*.5
    effectCanvas.y = button.height*.5
    effectCanvas.fill.effect.widthHeight = {button.width,button.height}
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
