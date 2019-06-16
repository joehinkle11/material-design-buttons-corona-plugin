local Library = require "CoronaLibrary"

-- Create library
local lib = Library:new{ name='materialdesignbuttons', publisherId='io.joehinkle.materialdesignbuttons' }

local widget = require "widget"

local shapes = require "plugin.materialdesignbuttons.shapes"

-------------------------------------------------------------------------------
-- BEGIN (Insert your implementation starting here)
-------------------------------------------------------------------------------

local oldNewButton = widget.newButton
lib.newButton = function( params )
	local button = oldNewButton( params )
	params.width = button.width
	params.height = button.height
	local shadow1 = shapes.shadow( params )
	local shadow2 = shapes.shadow( params )
	if shadow1 and shadow2 then
		shadow1.x = button.width*.5
		shadow1.y = button.height*.5
		shadow2.x = button.width*.5
		shadow2.y = button.height*.5 + 5.2
		button:insert(shadow1)
		shadow1:toBack()
		button:insert(shadow2)
		shadow2:toBack()
		-- for k,v in pairs(button) do
		-- 	print(k,v)
		-- end
		-- intercept setting z value
		local oldMetatable = getmetatable(button)
		local oldNewIndex = oldMetatable.__newindex
		setmetatable( button, {
			__index = oldMetatable.__index,
			__newindex = function( myTable,key,value )
				if key == "z" then
					print("z set to: "..tostring(value))
				else
					oldNewIndex( myTable, key, value )
				end
			end
		} )
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
