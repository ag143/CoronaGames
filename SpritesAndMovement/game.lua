local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- START:requireClasses
-- Require classes
require( "class" )
require( "gamesprite" )
require( "spaceship" )
require( "globals" )
spritedata = require( "shipsprites" )
spriteAnims = require( "spriteanims" )
-- END:requireClasses

-- START:shipsList
local ships = { }
-- END:shipsList

-- START:enemyTimer
-- Enemy count down timer
local nextEnemy = 0
-- END:enemyTimer

-- START:playerShipSprite
-- Player sprite
local spaceshipSprite
-- END:playerShipSprite

-- Called when the scene's view does not exist:
-- START:loadImageSheet
-- Load an image sheet
-- START:newSpaceshipInstance
function scene:createScene( event )
-- END:newSpaceshipInstance
-- END:loadImageSheet
    local group = self.view

    -- Load an image and add it to the scene's main group
    local image = display.newImage( "images/space_background.jpg" )
    image.anchorX, image.anchorY = 0, 0
    group:insert( image )

    -- START:loadImageSheet
    -- Load the image sheet
    imageSheet = graphics.newImageSheet( "images/shipsprites.png", 
        spritedata:getSheet( ) )
    -- END:loadImageSheet
    
    -- START:newSpaceshipInstance
    -- Create a new spaceship instance
    spaceshipSprite = Spaceship( )
    -- END:newSpaceshipInstance
-- START:loadImageSheet
-- START:newSpaceshipInstance
end
-- END:newSpaceshipInstance
-- END:loadImageSheet


-- START:updateCall
-- This function will update our enemies each frame
function updateEnemies( )
    -- Update the spaceship instance
    spaceshipSprite:update( )
end
-- END:updateCall

-- This function is called each frame and will add enemies to the game
function addEnemies( )
    -- print( "Enemies added" )
end


-- The tick function that will get called each frame
function tick( )
    -- Call several functions to update our game
    updateEnemies( )
    addEnemies( )
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
    local group = self.view
    
    -- Add an event listener 
    -- This will call the tick function each frame: 
    Runtime:addEventListener( "enterFrame", tick )
end


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