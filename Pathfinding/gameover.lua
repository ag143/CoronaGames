require( "globals" )

-- Corona Storyboard variables
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local bgimage = nil

-- START:gameOverScreen
-- Touch event listener for the menu's background image
-- Goes to the game scene
local gotoGame = function( event )
    -- Only process the event if the player started the tap
    if ( event.phase == "began" ) then
        storyboard.gotoScene( "game" )
    end
end

-- Adds the event listener
function addListener( event )
    bgimage:addEventListener( "touch", gotoGame )
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
    local group = self.view

    bgimage = display.newImage("images/game_over.jpg")
    bgimage.anchorX, bgimage.anchorY = 0, 0
    group:insert( bgimage )
    
    timer.performWithDelay( 2000, addListener )
end
-- END:gameOverScreen


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
    local group = self.view
    
	-- START:purgeGame
    -- If we come from the game, purge the previous scene
    storyboard.purgeScene( "game" )
	-- END:purgeGame
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
    local group = self.view
end


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