local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- START:includeTileMap
require( "tilemap" )
-- END:includeTileMap
-- START:includeGoldFunctions
require( "moneyfunctions" )
-- END:includeGoldFunctions
-- START:loadSprites
spritedata = require( "gamesprites" )
-- END:loadSprites
-- START:loadTowerBuilding
require( "towerbuilding" )
-- END:loadTowerBuilding

-- START:includeTileMap
mapLayer, towersLayer = nil, nil
-- END:includeTileMap

-- Called when the scene's view does not exist:
function scene:createScene( event )
    local group = self.view
    
    -- START:gameGroups
    -- Create groups
    mapLayer = display.newGroup( )
    towersLayer = display.newGroup( )
    group:insert( mapLayer )
    group:insert( towersLayer )
    -- END:gameGroups
    
    -- START:clearTowersInMap
    -- Clear the towersInMap variable
    clearTowersInMap( )
    -- END:clearTowersInMap
    
    -- START:drawMap
    -- Draw the map
    drawMap( mapLayer )
    -- END:drawMap
    
    -- START:tapBuildListener
    mapLayer:addEventListener( "touch", onTouchMap )
    towersLayer:addEventListener( "touch", onTouchMap )
    -- END:tapBuildListener
    
    -- START:loadSprites
    -- Create an image sheet
    imagesheet = graphics.newImageSheet( "images/gamesprites.png", 
        spritedata:getSheet( ) )
    -- END:loadSprites
    
    -- START:showGold
    -- Show the amount of gold
    showCurrency( group )
    -- END:showGold
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
    local group = self.view
    
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