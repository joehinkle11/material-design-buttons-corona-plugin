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
	local shadow = shapes.shadow( params )
	if shadow then
		shadow.x = button.width*.5
		shadow.y = button.height*.5
		button:insert(shadow)
		shadow:toBack()
		for k,v in pairs(button) do
			print(k,v)
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
