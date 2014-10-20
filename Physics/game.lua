-- Corona Storyboard variables
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- START:requiresAndPhysics
-- Requires
require( "arrayfuncs" )
widget = require( "widget" )
require( "physics" )
physics.start( )
-- END:requiresAndPhysics

local gameElements
local physicsData

-- START:crateType
-- Crate type variable
TYPE_CRATE = 1
local crates = { }
-- END:crateType

-- START:scoreVars
-- Score variables
local score = 0
local scoreTxt
-- END:scoreVars

-- START:addButtons
-- Make a new button
function addButton( px, py, w, h, callbackFunc )
    local myButton = widget.newButton{
        id = "btn"..px.."-"..py,
        left = px,
        top = py,
        width = w, 
        height = h,
        cornerRadius = 8,
        onEvent = callbackFunc
    }
    
    -- Make it invisible
    myButton.isVisible = false
    myButton.isHitTestable = true
    return myButton
end
-- END:addButtons

-- START:buttonGravity
-- Change the device gravity based on button input
function setButtonGravity( gx, gy )
    physics.setGravity( gx, gy )
end

-- Write the four gravity-related functions
function gravityLeft( event )
    setButtonGravity( -1, 0 )
end
function gravityTop( event )
    setButtonGravity( 0, -1 )
end
function gravityBottom( event )
    setButtonGravity( 0, 1 )
end
function gravityRight( event )
    setButtonGravity( 1, 0 )
end
-- END:buttonGravity

-- START:collisionFunc
-- START:updateScore
-- Collision listener function
function ballCollision( self, event )
    if ( event.phase == "began" ) then
        -- END:updateScore
        local object = event.other

        -- Remove active crates
        -- START:updateScore
        if ( ( object.type == TYPE_CRATE ) and 
            ( object.isAlive == true ) )then
            -- END:updateScore
            object.isAlive = false
            -- END:collisionFunc
            -- START:updateScore
            -- Update the score
            score = score + 1
            scoreTxt.text = score
            -- START:collisionFunc
        end
    end
end
-- END:updateScore
-- END:collisionFunc

-- Called when the scene's view does not exist:
function scene:createScene( event )
    local group = self.view

    -- START:makeSprite
    -- Load the image sheet
    gameElements = require( "gamesprites" )
    local gameObjectsSheet = graphics.newImageSheet( "images/gamesprites.png", 
        gameElements:getSheet() )

    -- Make the ball sprite
    ball = display.newImage( gameObjectsSheet , gameElements:getFrameIndex( "ball" ))
    ball.x = 160
    ball.y = 300
    group:insert( ball )
    -- END:makeSprite
    
    -- START:addWalls
    -- Make the wall sprites
    wallLeft = display.newImage( gameObjectsSheet, 
        gameElements:getFrameIndex("wall_left") )
    wallTop = display.newImage( gameObjectsSheet, 
        gameElements:getFrameIndex( "wall_top") )
    wallRight = display.newImage( gameObjectsSheet, 
        gameElements:getFrameIndex("wall_right") )
    wallBottom = display.newImage( gameObjectsSheet, 
        gameElements:getFrameIndex("wall_bottom") )
    
    -- Add them to the group
    group:insert( wallLeft )
    group:insert( wallTop )
    group:insert( wallRight )
    group:insert( wallBottom )
    
    -- Set their coordinates
    wallLeft.anchorX, wallLeft.anchorY = 0, 0
    wallTop.anchorX, wallTop.anchorY = 0, 0
    wallRight.anchorX, wallRight.anchorY = 0, 0
    wallBottom.anchorX, wallBottom.anchorY = 0, 0
    wallRight.x = 270
    wallTop.x = 50
    wallBottom.x = 50
    wallBottom.y = 444
    -- END:addWalls
    
    -- START:addButtons
    -- Add 4 buttons to the scene margins
    group:insert( addButton( 0, 0, 40, 480, gravityLeft ) )
    group:insert( addButton( 0, 0, 320, 40, gravityTop ) )
    group:insert( addButton( 0, 440, 320, 40, gravityBottom ) )
    group:insert( addButton( 280, 0, 40, 480, gravityRight ) )
    -- END:addButtons
    
    -- START:addPhysicsBodies
    -- Load the physics data file
    physicsData = (require "gameshapes").physicsData( 1.0 )

    -- Attach the circular polygon to the ball
    physics.addBody( ball, "ball", physicsData:get( "ball" ) )
    -- END:addPhysicsBodies
    
    -- START:ballCollision
    -- Add the collision listener
    ball.collision = ballCollision
    ball:addEventListener( "collision", ball )
    -- END:ballCollision
    
    -- START:addWallPhysics
    -- Add physics to the walls
    physics.addBody( wallLeft, "wall_left", physicsData:get("wall_left") )
    physics.addBody( wallTop, "wall_top", physicsData:get("wall_top") )
    physics.addBody( wallRight, "wall_right", physicsData:get("wall_right") )
    physics.addBody( wallBottom, "wall_bottom", physicsData:get("wall_bottom") )
    -- END:addWallPhysics

    -- START:addBodyTypes
    wallLeft.bodyType = "static"
    wallTop.bodyType = "static"
    wallRight.bodyType = "static"
    wallBottom.bodyType = "static"
    -- END:addBodyTypes
    
    -- START:addCrates
    -- Add the crates
    for i = 0, 2 do
        for j = 0, 2 do
		
            -- Add a crate
            local crateName = "crate" .. math.random( 3 )
            local crate = display.newImage( gameObjectsSheet, 
                gameElements:getFrameIndex( crateName ) )
            crate.x = 100 + 60 * j
            crate.y = 80 + 55 * i
            
            -- Define its properties
            crate.type = TYPE_CRATE
            crate.isAlive = true
            -- Add it to the group and table
            group:insert( crate )
            crates[ #crates + 1 ] = crate
            -- Add crate bodies
            physics.addBody( crate, "crate", physicsData:get( crateName ) )
            crate.bodyType = "kinematic"
        end
    end
    -- END:addCrates
    
    -- START:setGravityToNull
    -- Uncomment to disable gravity
    -- physics.setGravity( 0.0, 0.0 )
    -- END:setGravityToNull
    
    -- START:showScore
    -- Show the score
    scoreTxt = display.newText( group, score, 55, 
        420, 100, 20, native.systemFont, 16 )
    -- END:showScore
    
    -- START:setDrawModes
    -- Set the display mode for the physics engine
    --   use "hybrid" or "debug" for different results
    physics.setDrawMode( "normal" )
    -- END:setDrawModes
end

-- START:tiltFunction
-- Change gravity based on the phone's tilt
function tilt( event )
    -- Get the x and y accelerations
    local ax = event.xGravity
    local ay = -event.yGravity
    -- END:tiltFunction
    -- START:limitTiltAccelerations
    -- Limit tilt accelerations
    if ( math.abs( ax ) > 0.5 ) then
        ax = math.max( -0.5, math.min( 0.5, ax ) )
    end
    if ( math.abs( ay ) > 0.5 ) then
        ay = math.max( -0.5, math.min( 0.5, ay ) )
    end
    -- END:limitTiltAccelerations
    
    -- START:tiltFunction
    -- Set the gravity based on these values
    physics.setGravity( ax, ay )
end
-- END:tiltFunction

-- START:tickFunction
-- Tick function
function tick( event )
    -- Remove inactive crates
    for i = #crates, 1, -1 do
        if ( crates[i].isAlive == false ) then
            crates[i]:removeSelf( )
            removeTableRows( crates, i )
        end
    end
end
-- END:tickFunction

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
    local group = self.view
    
    -- START:addTiltListener
    Runtime:addEventListener( "accelerometer", tilt )  
    -- END:addTiltListener
    
    -- START:tickListener
    -- Tick
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


-- Add the scene event listeners
scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

-- Return the scene
return scene