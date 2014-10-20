-- START:towersInMap
function clearTowersInMap( )
    -- Loop through all the map's tiles, and initialize towersInMap to 0
    towersInMap = { }
    -- For each column
    for j = 1, #map do
        -- Initialize a list with values of 0 for each row
        towersInMap[j] = { }
        for i = 1, #( map[j] ) do
            towersInMap[j][i] = 0
        end
    end
end
-- END:towersInMap

-- START:buildOnTileCoord
function checkValidBuildTile( x, y )
    -- Get tile type
    local tileType = map[y][x]
    
    -- Get the tile type's buildable property
    -- END:buildOnTileCoord
    -- START:getTileType
    -- Get location in the tileProperties table
    local setCoordX = 1 + (tileType - 1) % 5
    local setCoordY = math.ceil( (tileType) / 5 )
    
    -- Get the tile build / walk type
    local buildType = tileProperties[setCoordY][setCoordX]
    -- END:getTileType

    -- START:checkTileBuild
    -- Check whether a tower can be built on this tile
    -- We can only build on this tile if it's a TILE_BUIL tile
    if ( buildType == TILE_BUIL ) then
        -- Return true if there are no towers in this tile
        -- print( "buildable" )
        return ( towersInMap[y][x] == 0 )
    else 
        -- print( "not buildable: " .. tileType .. ", " .. buildType )
        return false
    end
    -- END:checkTileBuild
    -- START:buildOnTileCoord
end
-- END:buildOnTileCoord

-- START:onTouchMap
function onTouchMap( event )
    if ( event.phase == "ended" ) then
        -- Calculate tile coordinates
        local tileX = math.ceil( event.x / TILE_WIDTH )
        local tileY = math.ceil( event.y / TILE_HEIGHT )
        
        -- Build only if the tile is valid and we have enough money
        if checkValidBuildTile( tileX, tileY ) and 
                hasEnoughMoneyToSpend( TOWER_COST ) then
            
            -- Subtract the money and build the tower
            subtractMoney( TOWER_COST )
            buildTower( tileX, tileY )
            
            -- START:updateTowerBuilding
            statistics.towersBuilt = statistics.towersBuilt + 1
            -- END:updateTowerBuilding
        end
    end
end
-- END:onTouchMap

-- START:sortBuildings
function sortTowers( )
    for j = 1, #map do
        for i = 1, #( map[j] ) do
            if ( towersInMap[j][i] ~= 0 ) then
                -- Tower found! Push it to the front
                towersInMap[j][i].spriteInstance:toFront( )
            end
        end
    end
end
-- END:sortBuildings

-- START:buildTower
function buildTower( x, y )
    -- Create a new tower sprite
    local tempTower = Tower( x, y, towersLayer )
    
    -- Store the tower in towersInMap
    towersInMap[y][x] = tempTower
    towers[#towers + 1] = tempTower
    
    -- Sort depths
    sortTowers( )
end
-- END:buildTower
