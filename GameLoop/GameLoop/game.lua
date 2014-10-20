local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- Called when the scene's view does not exist:
-- START:backgroundImage
-- Load a background image when the scene is created
function scene:createScene( event )
    local group = self.view

    -- END:backgroundImage
    -- START:backgroundImage
    -- Load an image and add it to the scene's main group
    local image = display.newImage( "images/space_background.jpg" )
    image.anchorX, image.anchorY = 0, 0
    group:insert( image )
    -- END:backgroundImage
    
-- START:backgroundImage
end
-- END:backgroundImage


-- START:tickFunctionBase
-- A placeholder for the tick function
--  Called every frame
function tick( )
    -- Here we'll add the code that needs to be executed each frame
end
-- END:tickFunctionBase

-- START:updateEnemies
-- This function will update our enemies each frame
function updateEnemies( )
    print( "Enemies updated" )
end
-- END:updateEnemies

-- START:addEnemies
-- This function is called each frame and will add enemies to the game
function addEnemies( )
    print( "Enemies added" )
end
-- END:addEnemies


-- START:tickFunction
-- The tick function that will get called each frame
function tick( )
    -- Call several functions to update our game
    updateEnemies( )
    addEnemies( )
end
-- END:tickFunction


-- START:tickListener
-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
    local group = self.view
-- END:tickListener
    
    -- START:tickListener
    -- Add an event listener 
    -- This will call the tick function each frame: 
    Runtime:addEventListener( "enterFrame", tick )
    -- END:tickListener
-- START:tickListener
end
-- END:tickListener


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
    local group = self.view
    
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
    local group = self.view
    
end


-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

return scene