local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- Require classes
require( "class" )
require( "gamesprite" )
require( "spaceship" )
require( "globals" )
spritedata = require( "shipsprites" )
spriteAnims = require( "spriteanims" )

-- START:shipsList
local ships = { }
-- END:shipsList
-- START:enemyTimer
-- Enemy count down timer
local nextEnemy = 0
-- END:enemyTimer
local spaceshipSprite

-- Called when the scene's view does not exist:
function scene:createScene( event )
    local group = self.view

    -- START:backgroundImage
    -- Load an image and add it to the scene's main group
    local image = display.newImage( "images/space_background.jpg" )
    image.anchorX, image.anchorY = 0, 0
    group:insert( image )
    -- END:backgroundImage
    
    -- Image sheet
    imageSheet = graphics.newImageSheet( "images/shipsprites.png", spritedata:getSheet( ) )
    
end


-- START:updateEnemies
-- START:loopEnemies
-- This function will update our enemies each frame
function updateEnemies( )
    -- Loop through each of the enemies and update them
    for i = #ships, 1, -1 do
        ships[ i ]:update( )
    end
end
-- END:loopEnemies
-- END:updateEnemies

-- START:addEnemies
-- START:newEnemy
-- This function is called each frame and will add enemies to the game
function addEnemies( )
-- END:newEnemy
    -- START:newEnemy
    -- Add a new enemy every 3 seconds
    nextEnemy = nextEnemy - 1
    if nextEnemy < 0 then
        -- 3 seconds have passed, so create a new ship
        local newShip = Spaceship( )
        ships[ #ships + 1 ] = newShip
        
        -- Reset the enemy counter
        nextEnemy = 90
    end
    -- END:newEnemy
-- START:newEnemy
end
-- END:newEnemy
-- END:addEnemies


-- START:tickFunction
-- The tick function that will get called each frame
function tick( )
    -- Call several functions to update our game
    updateEnemies( )
    addEnemies( )
end
-- END:tickFunction


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
    local group = self.view
    
    -- START:tickListener
    -- Add an event listener 
    -- This will call the tick function each frame: 
    Runtime:addEventListener( "enterFrame", tick )
    -- END:tickListener
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
    local group = self.view
    
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
    local group = self.view
    
end


---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

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

---------------------------------------------------------------------------------

return scene