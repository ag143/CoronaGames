-- Corona Storyboard variables
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local kiwi

-- [Title View]
local titleBg
local playBtn
local creditsBtn
local titleView

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
	--kiwi = display.newImage('images/kiwi.png', 23, 152)
	
	titleBg = display.newImage('images/titleBg.png')
	titleBg.anchorX, titleBg.anchorY = 0, 0
	group:insert(titleBg)
	playBtn = display.newImage('images/playBtn.png', 220, 178)
	group:insert(playBtn)
	creditsBtn = display.newImage('images/creditsBtn.png', 204, 240)
	group:insert(creditsBtn)
	
	-- START:addListenerToMenu
    playBtn:addEventListener( "touch", gotoGame )
    -- END:addListenerToMenu
   
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