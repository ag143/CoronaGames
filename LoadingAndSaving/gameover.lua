require( "globals" )

-- Corona Storyboard variables
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local bgimage = nil

-- START:returnToGame
-- Touch event listener for the menu's background image
-- Goes to the game scene
local returnToGame = function( event )
    -- Only process the event if the player started the tap
    if ( event.phase == "began" ) then
        storyboard.gotoScene( "game" )
    end
end

-- Adds the event listener
function addListener( event )
    bgimage:addEventListener( "touch", gotoGame )
end
-- END:returnToGame


-- START:touchListener
-- Prepare the scene
function scene:createScene( event )
    local group = self.view
	
    -- Add an image to the scene group
    image = display.newImage("images/game_over.jpg")
    image.anchorX, image.anchorY = 0, 0
    group:insert( image )
	
    -- Save the stats in the database
    saveStats( )
    loadStats( )
    prepareStatstoDisplay( )
	
    -- Add the stats boxes.  The values are temporary for now
    statNames = { "Games", "Kills", "Gold", "Towers", "Lives Lost" }
	
    -- statValues = { 1, 2, 3, 4, 5 }
    for i = 1, #statNames do
        -- Display each stat in a box
        local posX = 150
        local posY = 52 + i * 36
        local posX2 = 280
        local txt = display.newText( group, statNames[i], posX, 
            posY, 100, 30, native.systemFont, 16 )
        txt:setFillColor( 20/255, 20/255, 20/255 )
        txt.anchorX, txt.anchorY = 0, 0
        txt = display.newText( group, statValues[i], posX2, posY, 100, 
            30, native.systemFont, 16 )
        txt:setFillColor( 1, 240/255, 230/255 )
        txt.anchorX, txt.anchorY = 0, 0
    end
	
    -- Add the touch listener
    image:addEventListener( "touch", returnToGame )
end
-- END:touchListener


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
    local group = self.view
    
    -- If we come from the game, purge the previous scene
    storyboard.purgeScene( "game" )
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