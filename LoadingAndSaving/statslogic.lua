-- START:openDatabase
require( "sqlite3" )
-- END:openDatabase

-- START:createStatsDatabase
-- Open or create a new database in a file called "stats.db"
local path = system.pathForFile( "stats.db", system.DocumentsDirectory )
db = sqlite3.open( path )
-- END:createStatsDatabase
-- db = sqlite3.open_memory( )

-- Create the database if it doesn't exist

-- START:checkTableExists
-- Check the table doesn't exist
local exists = false
local query = [[SELECT name FROM sqlite_master WHERE 
type='table' AND name='stats']]

for row in db:nrows( query ) do 
    tableExists = true
end
-- END:checkTableExists

-- START:buildDatabase
-- Create a new table if one doesn't already exist 
--   and populate it with empty values
if not tableExists then
    db:exec[[
        CREATE TABLE IF NOT EXISTS stats             (id INTEGER PRIMARY KEY, games, kills, 
            gold, towers, lives);
			
        INSERT INTO stats VALUES (NULL, 0, 0, 0, 0, 0);
    ]]
end
-- END:buildDatabase

function closeDB( event )
    if( event.type == "applicationExit" ) then
        if ( db ~= nil and db:isopen( ) ) then
            db:close( )
        end
    end
end
-- Close DB on exit
Runtime:addEventListener( "system", closeDB )

-- START:saveStats
-- Save the stats
function saveStats( )
    -- Create an update query to update the stats table
    local query = [[UPDATE stats SET 
        games=games + ]]..statistics.gamesPlayed..[[, 
        kills=kills + ]]..statistics.kills..[[,
        gold=gold + ]]..statistics.gold..[[,
        towers=towers + ]]..statistics.towersBuilt..[[,
        lives=lives + ]]..statistics.livesLost..[[;
    ]]
    -- Execute the query
    db:exec( query )
end
-- END:saveStats

-- START:loadStats
-- Get the stats from the database
function loadStats( )
    for row in db:nrows("SELECT * FROM stats LIMIT 1") do
        -- Get the row's data
        statistics.gamesPlayed = row.games
        statistics.kills = row.kills
        statistics.gold = row.gold
        statistics.towersBuilt = row.towers
        statistics.livesLost = row.lives
    end
end
-- END:loadStats

-- START:showStats
-- Set the statsValues variable to display it in the stats scene
function prepareStatstoDisplay( )
    statValues = { 
        statistics.gamesPlayed,
        statistics.kills,
        statistics.gold,
        statistics.towersBuilt,
        statistics.livesLost
    }
end
-- END:showStats

