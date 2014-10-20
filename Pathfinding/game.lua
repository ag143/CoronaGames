local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
-- START:autopurge
storyboard.purgeOnSceneChange = true
-- END:autopurge

-- START:includeTileMap
require( "tilemap" )
-- END:includeTileMap
-- START:includeGoldFunctions
require( "moneyfunctions" )
-- END:includeGoldFunctions
spritedata = require( "gamesprites" )
require( "towerbuilding" )

-- START:newClasses
-- Require other code files
require( "auxiliary" )
require( "arrayfuncs" )
require( "class" )
require( "enemy" )
require( "creeps" )
require( "pathfinding-astar" )
require( "gamelogic" )
require( "tower" )
require( "beam" )
-- END:newClasses

-- START:includeTileMap
mapLayer, towersLayer = nil, nil
-- END:includeTileMap
-- START:emptyLayers
enemiesLayer = nil
beamsLayer = nil
-- END:emptyLayers

-- Reset the game variables when we enter a new game
function resetGameVars( )
-- START:resetGameVars
    towers = { }
    beams = { }
    enemies = { }
    level = 0
    lives = 5
    playerGold = 100
    getNextWaveData( level + 1 )
-- END:resetGameVars
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
    local group = self.view
    
    -- Reset enemy vars
    resetGameVars( )
    
    -- START:gameGroups
    -- Create groups
    mapLayer = display.newGroup( )
    towersLayer = display.newGroup( )
    group:insert( mapLayer )
    group:insert( towersLayer )
    -- END:gameGroups
    -- START:newGroups
    enemiesLayer = display.newGroup( )
    group:insert( enemiesLayer )
    beamsLayer = display.newGroup( )
    group:insert( beamsLayer )
    -- END:newGroups
    
    -- Clear the towersInMap variable
    clearTowersInMap( )
    
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
    imagesheet = graphics.newImageSheet( "images/gamesprites.png", spritedata:getSheet( ) )
    -- END:loadSprites
    
    -- Show the amount of gold
    showCurrency( group )
    
    -- START:showLivesCall
    -- Show the number of lives
    showLives( group )
    -- END:showLivesCall
    
    -- Paint a path
    -- findPath( 2, 1, 9, 7, group )
    -- addEnemies( enemiesLayer )
    -- moveEnemies( enemiesLayer )
    -- enemies[1]:toggleDelete( )
end

-- START:tickFunction
function tick( event )
    -- Add Enemies
    addEnemies( enemiesLayer )
    
	-- START:moveEnemies
    -- Move Enemies
    moveEnemies( enemiesLayer )
	-- END:moveEnemies
    
	-- START:updateTowers
    -- Update towers
    updateTowers( )
	-- END:updateTowers
    
	-- START:updateBeams
    -- Update beams
    updateBeams( )
	-- END:updateBeams
    
    -- START:jumpToGameOver
    -- Check game over conditions
    -- END:tickFunction
    if ( lives <= 0 ) then
        storyboard.gotoScene( "gameover" )
    end
    -- END:jumpToGameOver
    -- START:tickFunction
end
-- END:tickFunction

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
    local group = self.view

    Runtime:addEventListener( "enterFrame", tick )
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
    local group = self.view
    
    Runtime:removeEventListener( "enterFrame", tick )
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