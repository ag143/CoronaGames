-- START:requires
-- Require classes
-- END:requires
local storyboard = require( "storyboard" )
-- Corona's Sprite API

-- Require code files
-- Auxiliary files
-- START:requires
require( "globals" )
require( "arrayfuncs" )
require( "unit" )
-- END:requires
-- Load the sprite data file
-- START:requires
spritedata = require( "shipsprites" )
spriteSequences = require( "shipanims" )
-- END:requires

-- START:variableList
-- Variables
local enemies = {}
local lastEnemy = 0
local scene = storyboard.newScene()
local sceneView
local playerInstance, background
local imagesheet
-- END:variableList
-- START:parallaxLayers
local parallax1, parallax2
-- END:parallaxLayers
-- START:asteroidGroup
local asteroids
-- END:asteroidGroup

-- START:loadParallaxLayer
-- Load a background image and add it to a parallax layer
function loadParallaxLayer( sceneGroup, imageName )
    -- Create a group
    local parallaxGroup = display.newGroup( )
    
    -- Load the background image twice and add them to the group
    local bgImage = display.newImage( imageName )
    parallaxGroup:insert( bgImage )
    bgImage.anchorX, bgImage.anchorY = 0, 0
    bgImage.y = 0
    
    bgImage = display.newImage( imageName )
    parallaxGroup:insert( bgImage )
    bgImage.anchorX, bgImage.anchorY = 0, 0
    bgImage.y = -bgImage.height
    
    -- Add the parallax group to the scene
    sceneGroup:insert( parallaxGroup )
    parallaxGroup.y = 0
    
    -- Return the group
    return parallaxGroup
end
-- END:loadParallaxLayer

-- START:makeAsteroid
-- Create an asteroid using our random images
function makeAsteroid( group )
    -- Create a group to store the asteroid
    local newGroup = display.newGroup()
    
    -- Choose a random image for the asteroid base and its crater
    local rockName = ASTEROID_NAME..math.random( ASTEROID_VARIANCE )
    local rock = display.newImage( imagesheet, 
        spritedata:getFrameIndex(rockName) )
    local craterName = CRATER_NAME..math.random( CRATER_VARIANCE )
    local crater = display.newImage( imagesheet, 
        spritedata:getFrameIndex(craterName) )
    
    -- Insert the images and set a random position for the group
    newGroup:insert( rock )
    newGroup:insert( crater )
    newGroup.x = 40 + math.random( 240 )
    newGroup.y = math.random( 480 )
    -- Set a random position for the crater
    rock.x = 0
    rock.y = 0
    crater.x = 10 + math.random( 40 )
    crater.y = 10 + math.random( 40 )
    -- Add everything to the asteroids layer
    group:insert( newGroup )
end
-- END:makeAsteroid

-- Resets the game variables before a new game
function resetGameVars( )
-- START:resetGameVars
    enemies = {}
    lastEnemy = 0
-- END:resetGameVars
end


-- START:resetGame
-- Called when the scene's view does not exist:
function scene:createScene( event )
-- END:resetGame
    local group = self.view
    
    -- START:parallaxInit
    -- Create the parallax layers
    parallax2 = loadParallaxLayer( group, "images/parallaxbg.jpg" )
    parallax1 = loadParallaxLayer( group, "images/parallaxfg.png" )
    -- END:parallaxInit
    
    -- START:loadSprites
    -- Create an image sheet
    imagesheet = graphics.newImageSheet( "images/shipsprites.png", spritedata:getSheet( ) )
    -- END:loadSprites
    
    -- START:asteroids
    -- Create a group to hold the asteroids
    asteroids = display.newGroup()
    -- Create two asteroids and add them to the scene group
    for i = 1, 2 do
        makeAsteroid( asteroids )
    end
    group:insert( asteroids )
    -- END:asteroids
    
    -- START:initPlayer
    -- Initialize the player
    playerInstance = Player( group, imagesheet )
    -- END:initPlayer
-- START:resetGame
end
-- END:resetGame


-- START:updateAsteroids
-- updateAsteroids( )
-- Updates the asteroids' positions
function updateAsteroids( )
    for i = asteroids.numChildren, 1, -1 do
        -- Move the asteroid
        asteroids[ i ].y = asteroids[ i ].y + parallaxCoefficient1
        
        -- Move asteroids back to the top of the screen 
        --   after they move out of bounds
        if asteroids[ i ].y > 530 then
            asteroids[ i ].y = -50 - math.random( 50 )
            asteroids[ i ].x = 40 + math.random( 240 )
        end
    end
end
-- END:updateAsteroids

-- onPlayerTouch
-- START:playerListener
-- Handles the game's touch event listener and 
--   updates the player's position accordingly
local function onPlayerTouch( event )
    if event.phase ~= "ended" then
        -- If the player keeps pressing the screen, 
        --   save the touch location as the target position
        playerInstance:setTargetPosition( event.x, event.y )
    else
        -- When the touch event ends, stop moving the player
        playerInstance:resetTargetPosition( )
    end
end
-- END:playerListener


-- START:updateParallax
-- Updates the parallax each frame
local function updateParallax( )
    -- Move in the y direction (using the coefficient in globals.lua)
    parallax2.y = parallax2.y + parallaxCoefficient2
    parallax1.y = parallax1.y + parallaxCoefficient1
    
    -- Reset the layers' positions if they scroll out of the scene
    if parallax2.y >= parallax2[1].height then
        parallax2.y = parallax2.y - parallax2[1].height
    end
    if parallax1.y >= parallax1[1].height then
        parallax1.y = parallax1.y - parallax1[1].height
    end
end
-- END:updateParallax


-- updateEnemies
-- START:enemyMovement
-- Update the enemies
local function updateEnemies( group )
    -- Loop through all the enemies 
    --  (backwards in case we remove some from the table)
    for i = #enemies, 1, -1 do
        -- Move the enemy
        enemies[ i ]:move( )
        -- END:enemyMovement
        
        -- START:deleteEnemiesWithExplosion
        -- START:enemyMovement
        -- Delete inactive enemies
        if ( enemies[ i ]:toggleDelete( ) == true ) then
            -- Remove the enemy
            enemies[ i ]:removeMe( )
            removeTableRows( enemies, i, 1 )
        end
        -- END:deleteEnemiesWithExplosion
    end
end
-- END:enemyMovement


-- START:addEnemies
-- addEnemies
-- Adds an enemy if we've waited enough time
local function addEnemies( group )
    lastEnemy = lastEnemy - 1
	
    if ( lastEnemy <= 0 ) then
        -- Add the enemy
        lastEnemy = math.random( ENEMY_DELAY ) + ENEMY_DELAY
        enemies[ #enemies + 1 ] = Enemy( group, imagesheet )
    end
	
end
-- END:addEnemies

-- tick
-- START:tickFunction
-- The game's main update function
local function tick( event )
    local group = sceneView
	-- END:tickFunction
    
    -- START:tickUpdateParallax
    -- Update the parallax layers
    updateParallax( )
    -- END:tickUpdateParallax
    
    -- START:playerAndEnemyMovement
    -- Update the player
    playerInstance:move( )
    
    -- Update enemies
    updateEnemies( group )
    -- END:playerAndEnemyMovement
    
    -- START:enemiesAdd
    -- Add enemies
    addEnemies( group )
    -- END:enemiesAdd
    
    -- START:moveAsteroids
    -- Update the asteroids
    updateAsteroids( )
    -- END:moveAsteroids
    
	-- START:tickFunction
end
-- END:tickFunction


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
    -- START:addListeners
	-- Store the scene group to access it later
    local group = self.view
    sceneView = group
    -- END:addListeners
    
    -- START:resetGame
    -- Reset game variables
    resetGameVars( )
    -- END:resetGame
    
    -- START:purgeMenu
    -- If we come from the menu, purge the previous scene
    storyboard.purgeScene( "menu" )
    -- END:purgeMenu
    
    -- START:enterSceneGroupCoords
    group.yReference = 0
    group.y = 0
    -- END:enterSceneGroupCoords
    
    -- START:addListeners
	-- Add the event listeners
    group:addEventListener( "touch", onPlayerTouch )
    Runtime:addEventListener( "enterFrame", tick )
    -- END:addListeners
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