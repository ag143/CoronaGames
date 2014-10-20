-- hide the status bar
display.setStatusBar(display.HiddenStatusBar)

-- Require the storyboard API and go to the game scene
local storyboard = require "storyboard"
storyboard.gotoScene( "game" )
