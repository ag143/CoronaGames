local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- Require classes
require( "class" )
require( "gamesprite" )
require( "spaceship" )
require( "globals" )
require( "arrayfuncs" )
spritedata = require( "shipsprites" )
spriteAnims = require( "spriteanims" )

-- START:shipsList
local ships = { }
-- END:shipsList
local nextEnemy = 0
local spaceshipSprite


-- Called when the scene's view does not exist:
-- START:heartGroup
function scene:createScene( event )
    local group = self.view
-- END:heartGroup

    -- START:backgroundImage
    -- Load an image and add it to the scene's main group
    local image = display.newImage( "images/space_background.jpg" )
    image.anchorX, image.anchorY = 0, 0
    group:insert( image )
    -- END:backgroundImage
    
    -- START:heartGroup
    -- Add a group to display the lives
    lifeGroup = display.newGroup( )
    group:insert( lifeGroup )
    -- END:heartGroup
    
    -- Image sheet
    imageSheet = graphics.newImageSheet( "images/shipsprites.png", spritedata:getSheet( ) )
    
-- START:heartGroup
end
-- END:heartGroup


-- START:updateTick
-- This function will update our enemies each frame
-- START:checkLives
function updateEnemies( )
-- END:checkLives
    -- Loop through each of the enemies and update them
	
    -- START:checkLives
    for i = #ships, 1, -1 do
        -- END:checkLives
        ships[ i ]:update( )
        -- START:checkLives
		
        -- Remove dead ships
        if ( ships[ i ]:toggleDelete( ) == true ) then
            -- END:updateTick
            -- If the ship was not killed by the player, subtract a life
            if ( ships[ i ].wasKilled == false ) then
                lives = lives - 1
                -- END:checkLives
                -- START:removeLife
                lifeGroup[ lifeGroup.numChildren ]:removeSelf( )
                -- END:removeLife
                -- START:checkLives
            end
            -- END:checkLives
            
            -- START:updateTick
            ships[ i ]:removeMe( )
            removeTableRows( ships, i )
            -- START:checkLives
        end
    end
    -- END:updateTick
    -- Check the number of lives
    if lives <= 0 then
        storyboard.gotoScene( "gameover" )
    end
    -- END:checkLives
    -- START:updateTick
-- START:checkLives
end
-- END:checkLives
-- END:updateTick

-- START:tappedFunc
-- Function triggered when a spaceship is tapped
local tappedShip = function( event )
    -- Mark the ship as dead
    event.target.object.isAlive = false
end
-- END:tappedFunc

-- START:addEnemies
-- This function is called each frame and will add enemies to the game
-- START:addEnemyTick
function addEnemies( )
    -- Add a new enemy every 3 seconds
    nextEnemy = nextEnemy - 1
    if nextEnemy < 0 then
        -- 3 seconds have passed, so create a new ship
        local newShip = Spaceship( )
        ships[ #ships + 1 ] = newShip
        -- Add a touch event listener to the ship
        newShip.spriteInstance:addEventListener( "touch", tappedShip )
        -- Reset the enemy counter
        nextEnemy = 90
        -- END:addEnemyTick
        -- START:nextShipCalc
        -- Reset the enemy counter
        shipsAdded = shipsAdded + 1
        nextEnemy = 33 / ( math.log( 1 + shipsAdded / 5 ) + 1 )
        -- END:nextShipCalc
        -- START:addEnemyTick
    end
    -- END:addEnemyTick
-- START:addEnemyTick
end
-- END:addEnemyTick
-- END:addEnemies


-- START:tickFunction
-- The tick function that will get called each frame
function tick( )
    -- Call several functions to update our game
    addEnemies( )
    updateEnemies( )
end
-- END:tickFunction


-- Called immediately after scene has moved onscreen:
-- START:livesVar
-- START:nextShipTrack
-- START:paintLives
function scene:enterScene( event )
-- END:paintLives
-- END:nextShipTrack
-- END:livesVar
    local group = self.view
    
    -- START:livesVar
    -- Start tracking player lives
    lives = 3
    -- END:livesVar
    
    -- START:nextShipTrack
    -- Create a variable to store the number of ships added
    shipsAdded = 0
    -- END:nextShipTrack
    nextEnemy = 0

    -- START:paintLives
    -- Display the lives
    for i = 1, 3 do
        local lifeSprite = display.newImage( imageSheet, 
            spritedata:getFrameIndex( IMG_LIFE ) )
        lifeSprite.x = 15 * i - 5
        lifeSprite.y = 10
        lifeGroup:insert( lifeSprite )
    end
    -- END:paintLives
    
    -- START:tickListener
    -- Add an event listener 
    -- This will call the tick function each frame: 
    Runtime:addEventListener( "enterFrame", tick )
    -- END:tickListener
-- START:livesVar
-- START:nextShipTrack
-- START:paintLives
end
-- END:paintLives
-- END:nextShipTrack
-- END:livesVar


-- Called when scene is about to move offscreen:
-- START:cleanShips
function scene:exitScene( event )
-- END:cleanShips
    local group = self.view
    
    -- START:cleanShips
    -- Remove the "tick" listener
    Runtime:removeEventListener( "enterFrame", tick )
    
    -- END:cleanShips
    -- START:cleanShips
    -- Remove the ships
    for i = #ships, 1, -1 do
        ships[ i ]:removeMe( )
    end
    ships = { }
end
-- END:cleanShips


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