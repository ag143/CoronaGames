-- Corona Storyboard variables
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- START:includeWidget
-- Require the widget class
widget = require "widget"
-- END:includeWidget

-- START:gotoGame
-- Touch event listener for the menu's background image
-- Goes to the game scene
local gotoGame = function( event )
    -- Only process the event if the player started the tap
    if event.phase == "ended" then
        storyboard.gotoScene( "game" )
    end
end
-- END:gotoGame


-- Called when the scene's view does not exist:
-- START:newBGImage
-- START:addListenerToMenu
-- START:useSpriteForButton
function scene:createScene( event )
    local group = self.view
-- END:useSpriteForButton
-- END:addListenerToMenu
-- END:newBGImage

    -- START:newBGImage
    -- Add an image to the scene
    local bgimage = display.newImage("images/menu_bg.jpg")
    bgimage.anchorX, bgimage.anchorY = 0, 0
    group:insert( bgimage )
    -- END:newBGImage
    
    -- START:addListenerToMenu
    bgimage:addEventListener( "touch", gotoGame )
    -- END:addListenerToMenu
    
    -- START:useSpriteForButton
    -- Create a new sprite sheet
    menuSheets = graphics.newImageSheet( "images/menu_buttons.png", 
        { width = 120, height = 40, numFrames = 2 } )
    -- END:useSpriteForButton
    
    -- START:playButtonBuild
    -- Build a "Play" button
    -- START:useSpriteForButton
    local playButton = widget.newButton{
    -- END:useSpriteForButton
        id = "btnplay",
        label = "Play",
        labelColor = { default={ 0, 0, 0 } },
        left = 100,
        top = 200,
        width = 120, 
        height = 40,
        cornerRadius = 10,
        -- END:playButtonBuild
        -- START:useSpriteForButton
        -- Make the button use the sprite sheet
        sheet = menuSheets,
        defaultFrame = 1,
        overFrame = 2,
        -- END:useSpriteForButton
        -- START:playButtonBuild
        onEvent = gotoGame
    -- START:useSpriteForButton
    }
    -- END:useSpriteForButton
    group:insert( playButton )
    -- END:playButtonBuild
    
-- START:addListenerToMenu
-- START:newBGImage
-- START:useSpriteForButton
end
-- END:useSpriteForButton
-- END:addListenerToMenu
-- END:newBGImage

-- Called immediately after scene has moved onscreen:
-- START:purgeScene
function scene:enterScene( event )
-- END:purgeScene
    local group = self.view
    
    -- START:purgeScene
    storyboard.purgeScene( "gameover" )
end
-- END:purgeScene


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