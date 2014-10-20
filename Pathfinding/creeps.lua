-- START:creepVars
level = 0
enemies = { }
lives = 5
-- END:creepVars

-- START:enemyWavesTable
-- Enemy waves: creep type, speed, hit points, number of creeps, 
--   spawn delay, and gold per kill
enemyWaves = {
    { 1, 4, 10, 10, 100, 5 },
    { 2, 4, 15, 8, 70, 5 },
    { 3, 2, 20, 6, 30, 10 },
    { 4, 4, 10, 30, 25, 6 },
    { 1, 1, 100, 1, 50, 50 }
}
function getNextWaveData(wave)
    -- Get current wave data
    local enemyWave = enemyWaves[wave]
    creepData = {
        type = enemyWave[1],
        speed = enemyWave[2],
        hp = enemyWave[3],
        number = enemyWave[4],
        spawnDelay = enemyWave[5],
        moneyPerKill = enemyWave[6]
    }
    -- END:enemyWavesTable
    
    -- START:gameTimer
    -- Calculate the next wave delays
    nextEnemySpawn = creepData.spawnDelay + 30
    nextWaveSpawn = creepData.number
    spawnedEnemies = 0
    -- END:gameTimer
    -- START:enemyWavesTable
end
getNextWaveData( 1 )
-- END:enemyWavesTable

-- START:getLevelDifficulty
function adjustDifficulty( level )
    -- Adjust the level round if we've looped through all the levels
    local levelRound = math.ceil( ( level + 1 ) / #enemyWaves )

    -- Adjust the level's parameters based on the current level round
    creepData.spawnDelay = math.ceil( 1 + creepData.spawnDelay / 
        ( levelRound * gameDifficultyIncrease.creepMultiplier ) )
    creepData.number = levelRound * gameDifficultyIncrease.creepMultiplier
    creepData.hp = levelRound * gameDifficultyIncrease.healthCoeff
end
-- END:getLevelDifficulty

-- START:gameTickEnemySpawn
function addEnemies( group )
    -- Add new enemies periodically
    nextEnemySpawn = nextEnemySpawn - 1
    if ( nextEnemySpawn == 0 ) then
        enemies[#enemies + 1] = Enemy( spawnCoordinates, group, creepData )
        nextEnemySpawn = creepData.spawnDelay
        -- print( creepData.spawnDelay )
        spawnedEnemies = spawnedEnemies + 1
        -- Check if the wave ended
        -- print( spawnedEnemies .. ", " .. nextWaveSpawn )
        if ( spawnedEnemies == nextWaveSpawn ) then
            spawnedEnemies = 0
            level = level + 1
            -- print( "level: " .. level )
            getNextWaveData( 1 + level % #enemyWaves )
            adjustDifficulty( level )
        end
    end
end
-- END:gameTickEnemySpawn

-- START:moveAndRemove
-- START:enemyMove
-- Move enemies in the game
function moveEnemies( )
    -- Loop through all enemies
    for i = #enemies, 1, -1 do
        -- END:enemyMove
		
        -- ...
		
        -- END:moveAndRemove
        -- START:enemyMove
        local enemy = enemies[i]
        enemy:move( )
        -- END:enemyMove
        
        -- START:moveAndRemove
		
        -- Remove inactive enemies
        if ( enemy:toggleDelete( ) == true ) then
            enemy:removeMe( )
            removeTableRows( enemies, i )
        end
        -- START:enemyMove
    end
end
-- END:enemyMove
-- END:moveAndRemove
