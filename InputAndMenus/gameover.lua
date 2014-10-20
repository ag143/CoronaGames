-- Corona Storyboard variables
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- START:includeWidget
-- Require the widget class
widget = require "widget"
-- END:includeWidget

-- START:gotoMenu
-- Touch event listener for the menu's background image
-- Goes to the menu scene
local gotoMenu = function( event )
    -- Only process the event if the player started the tap
    if event.phase == "ended" then
        storyboard.gotoScene( "menu" )
    end
end
-- END:gotoMenu


-- START:gameOverScene
-- Menu listener function. Add a touch listener to the image
function addMenuListener( event )
    bgimage:addEventListener( "touch", gotoMenu )
end

-- Add an image during the scene creation process
function scene:createScene( event )
    local group = self.view

    -- Add a background image to the game over scene
    bgimage = display.newImage( "images/game_over.jpg" )
    bgimage.anchorX, bgimage.anchorY = 0, 0
    group:insert( bgimage )
    
end
-- END:gameOverScene


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
    local group = self.view
    
    -- START:addListenerWithDelay
    -- Add a tap event listener to return to the menu
    --   but only after some time, to avoid accidental returning
    timer.performWithDelay( 500, addMenuListener )
    -- END:addListenerWithDelay
    
    -- START:purgeGame
    -- If we come from the game, purge the previous scene
    storyboard.purgeScene( "game" )
    -- END:purgeGame
    
end

-- Called when scene is about to move offscreen:
-- START:removeListener
function scene:exitScene( event )
    bgimage:removeEventListener( "touch", gotoMenu )
-- END:removeListener
    local group = self.view
-- START:removeListener
end
-- END:removeListener


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
    local group = self.view
end


-- Add the scene event listeners
scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

-- Return the scene
return scene