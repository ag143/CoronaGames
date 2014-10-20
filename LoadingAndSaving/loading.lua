-- START:checkSpawnPoint
-- Check whether a spawn point is in the map
function wrongSpawnPoint( coord, tileMap )
    -- Check x and y are within bounds. 
    -- Return false if they are not. 
    if ( coord[1] < 0 ) or ( coord[1] > #tileMap[1] ) then
        return true
    end
    if ( coord[2] < 0 ) or ( coord[2] > #tileMap ) then
        return true
    end   
    return false
end
-- END:checkSpawnPoint


-- START:loadLevelInfo
-- Load a level file and store it in memory
function loadLevelInfo( levelName )
    -- Load the file
    levelName = string.gsub (levelName, "\r", "")
    local fullPath = system.pathForFile( "files/" .. levelName, 
        system.ResourceDirectory )
    local fh = io.open( fullPath, "r" )
    -- Skip 3 lines: 
    fh:read( "*l" )
    fh:read( "*l" )
    fh:read( "*l" )
    
    -- Load the map
    -- END:loadLevelInfo
    -- START:loadLevelMap
    -- Load the map
    -- Get the number of map rows and columns
    local cols = fh:read( "*n" )
    local rows = fh:read( "*n" )
    fh:read( "*l" )

    -- Read the tiles
    tileMap = { }
    for i = 1, rows do
        tileMap[i] = { }
        for j = 1, cols do
            -- Read the tile and store it in the tile list
            local tile = fh:read( "*n" )
            tileMap[i][j] = tile
        end
    end
    -- END:loadLevelMap
    -- START:loadLevelInfo
    -- Load the spawn coordinates
    -- END:loadLevelInfo
    -- Skip 3 lines
    fh:read( "*l" )
    fh:read( "*l" )
    fh:read( "*l" )
    
    -- START:loadSpawnPoints
    -- Load the spawn coordinates
    spawnPoints = { }
    spawnPoints[1] = { fh:read( "*n" ), fh:read( "*n" ) }
    spawnPoints[2] = { fh:read( "*n" ), fh:read( "*n" ) }
    -- Check the spawn points
    -- Check the spawn point is valid
    if ( ( wrongSpawnPoint( spawnPoints[1], tileMap ) ) or
        ( wrongSpawnPoint( spawnPoints[2], tileMap ) ) ) then
        print "Invalid spawn points"
    end
    -- END:loadSpawnPoints
    -- START:loadLevelInfo
    -- Load the enemy data
    -- END:loadLevelInfo
    -- Skip 3 lines
    fh:read( "*l" )
    fh:read( "*l" )
    fh:read( "*l" )
    fh:read( "*l" )
    
    -- START:loadCreepData
    -- Load the enemy data
    local numSpawnPoints = fh:read( "*n" )
    fh:read( "*l" )
    
    -- Load the enemies
    creepData = { }
    for i = 1, numSpawnPoints do
        -- Load enemy type
        creepData[i] = { fh:read("*n"), fh:read("*n"),
            fh:read("*n"), fh:read("*n"), fh:read("*n"),
            fh:read("*n") }
    end
    -- END:loadCreepData
    -- START:loadLevelInfo
end
-- END:loadLevelInfo



-- START:openLevelFile
-- Get the path and open the file from the resource directory
local fullPath = system.pathForFile( "files/levels.txt", system.ResourceDirectory )
local fh = io.open( fullPath, "r" )
-- END:openLevelFile

-- START:loadLevelList
-- Get the number of levels
local numLevels = fh:read( "*n" )
fh:read("*l")

-- Initialize Level Data
levelMaps = { }
creepInfo = { }
spawnPos = { }

-- Load each of the level files
for i = 1, numLevels do
    local levelName = fh:read("*l")
    loadLevelInfo( levelName )
    -- Store the level in the game's level array
    levelMaps[i] = tileMap
    spawnPos[i] = spawnPoints
    creepInfo[i] = creepData
end
-- END:loadLevelList
