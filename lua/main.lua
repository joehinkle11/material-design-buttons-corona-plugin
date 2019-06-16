--
-- Abstract: materialdesignbuttons Library Plugin Test Project
--
-- This is an example Corona Project documenting how
-- to use the Material Design Buttons library.
--
-- Created by Joseph Hinkle
--
------------------------------------------------------------

-- Load plugin library
local materialDesignButtons = require "plugin.materialdesignbuttons"
materialDesignButtons.initHooks()

local widget = require "widget"

-------------------------------------------------------------------------------
-- BEGIN (Insert your sample test starting here)
-------------------------------------------------------------------------------

-- screen positioning
local screenW = display.contentWidth
local screenH = display.contentHeight
local screenAW = display.actualContentWidth
local screenAH = display.actualContentHeight
local screenCX = display.contentCenterX
local screenCY = display.contentCenterY
local screenL = -(screenAW-screenW)*.5
local screenR = screenAW-(screenAW-screenW)*.5
local screenT = -(screenAH-screenH)*.5
local screenB = screenAH-(screenAH-screenH)*.5



local bg = display.newRect( screenCX, screenCY, screenAW, screenAH )
bg:setFillColor( 1 )


local button; button = widget.newButton({
	x = screenCX,
	y = screenCY - 40,
    shape = "roundedRect",
	label = "BUTTON",
    width = 120,
    height = 40,
    font = "Roboto-Medium.ttf",
    cornerRadius = 4,
    -- z = 10,
    onRelease = function ()
        button.z = button.z + 1
    end,
    labelColor = { default={ 1 }, over={ 1 } },
    fillColor = { default={87 / 255,   29 / 255,  229 / 255 }, over={127 / 255,   69 / 255,  269 / 255 } },
})


-- button.z = 10


local button = widget.newButton({
    x = screenCX,
    y = screenCY + 40,
    shape = "roundedRect",
    label = "BUTTON",
    width = 120,
    height = 40,
    font = "Roboto-Medium.ttf",
    cornerRadius = 4,
    hideShadow = true,
    labelColor = { default={ 1 }, over={ 1 } },
    fillColor = { default={87 / 255,   29 / 255,  229 / 255 }, over={127 / 255,   69 / 255,  269 / 255 } },
})


button.z =10




-------------------------------------------------------------------------------
-- END
-------------------------------------------------------------------------------
