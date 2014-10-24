local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
-- Physics

local physics = require('physics')
physics.start()
--physics.setDrawMode('hybrid')

-- Require classes
require( "class" )
require( "gamesprite" )
require( "spaceship" )
require( "globals" )
require( "arrayfuncs" )

-- START:shipsList
local ships = { }
-- END:shipsList
local nextEnemy = 0
local spaceshipSprite

-- Blocks

local blocks = {}

-- Called when the scene's view does not exist:
-- START:heartGroup
function scene:createScene( event )
    local group = self.view
-- END:heartGroup

    -- START:backgroundImage
    -- Load an image and add it to the scene's main group
    local image = display.newImage( "images/grassBg.jpg" )
    image.anchorX, image.anchorY = 0, 0
    group:insert( image )
    -- END:backgroundImage
	
	-- add kiwi
    kiwi = display.newImage('images/kiwi.png', 23, 152)
	physics.addBody( kiwi, "dynamic", { friction=0.5, bounce=0 } ) 
	kiwi.x = math.random(100,_W-100)
	kiwi.y = 170
	kiwi.myName = KIWI
	
	-- Walls
	
	local top = display.newRect(0, 60, 480, 1)
	top:setFillColor(34, 34, 34)
	local bottom = display.newRect(0, 260, 480, 1)
	bottom:setFillColor(34, 34, 34)
	
	-- Add physics
	
	
	physics.addBody(top, 'static')
	physics.addBody(bottom, 'static')
	

end
-- END:heartGroup
function createBlock()
	local b
	local rnd = math.floor(math.random() * 4) + 1
	b = display.newImage('images/block.png', display.contentWidth, yPos[math.floor(math.random() * 3)+1])
	b.name = 'block'
	-- Block physics
	physics.addBody(b, 'kinematic')
	b.isSensor = true
	blocks:insert(b)
end

-- START:tickFunction
-- The tick function that will get called each frame
function tick( )
    -- Call several functions to update our game
	createBlock()
	counter = counter + 1
	utils:log("game", counter)
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
    
    blocks = display.newGroup()
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