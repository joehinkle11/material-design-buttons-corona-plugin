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
	y = screenCY - 120*2,
    shape = "roundedRect",
	label = "CORONA BUTTON",
    width = 156,
    height = 40,
    font = "Roboto-Medium.ttf",
    cornerRadius = 4,
    z = 0,
    onRelease = function ( event )
        transition.to( button, { time = 500, transition = easing.inOutQuad, z = 3 } )
    end,
    -- hideShadow = true,
    labelColor = { default={ 1 }, over={ 1 } },
    fillColor = { default={87 / 255,   29 / 255,  229 / 255 }, over={127 / 255,   69 / 255,  269 / 255 } },
})



local noShadowButton; noShadowButton = widget.newButton({
    x = screenCX,
    y = screenCY - 165,
    shape = "roundedRect",
    label = "ROTATE",
    width = 90,
    height = 40,
    font = "Roboto-Medium.ttf",
    cornerRadius = 4,
    onRelease = function()
        transition.to( noShadowButton, { time = 50, transition = easing.inOutQuad, rotation = noShadowButton.rotation + 35 } )
    end,
    hideShadow = true,
    labelColor = { default={ 1 }, over={ 1 } },
    fillColor = { default={87 / 255,   29 / 255,  229 / 255 }, over={127 / 255,   69 / 255,  269 / 255 } },
})




local polyButton = widget.newButton({
    x = screenCX,
    y = screenCY - 10,
    shape = "polygon",
    label = "POLYGONS WORK\n     BECAUSE OF\nCUSTOM SHADER",
    width = 120,
    height = 40,
    vertices = { 0,-110, 27,-35, 105,-35, 43,16, 65,90, 0,45, -65,90, -43,15, -105,-35, -27,-35, },
    font = "Roboto-Medium.ttf",
    fontSize = 12,
    touchCircleColor = { 0 },
    labelColor = { default={ 0 }, over={ 0 } },
    fillColor = { default={.85, 1, .85 }, over={ .65, .85, .65  } },
})

local circleButton; circleButton = widget.newButton({
    x = screenCX,
    y = screenCY + 190,
    shape = "circle",
    label = "CHANGE COLOR",
    radius = 75,
    font = "Roboto-Medium.ttf",
    onRelease = function()
        circleButton:setFillColor( .85 + math.random( 0, 1 )*.15, .85 + math.random( 0, 1 )*.15, .85 + math.random( 0, 1 )*.15 )
    end,
    onPress = function()
        circleButton:setFillColor( .85 + math.random( 0, 1 )*.15, .85 + math.random( 0, 1 )*.15, .85 + math.random( 0, 1 )*.15 )
    end,
    cornerRadius = 4,
    touchCircleColor = { 0 },
    labelColor = { default={ 0 }, over={ 0 } },
    fillColor = { default={.85 + math.random( 0, 1 )*.15, .85 + math.random( 0, 1 )*.15, .85 + math.random( 0, 1 )*.15 }, over={ 1 } },
})











-------------------------------------------------------------------------------
-- END
-------------------------------------------------------------------------------
