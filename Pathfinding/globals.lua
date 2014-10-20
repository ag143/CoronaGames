-- Game sizes
STAGE_WIDTH = 480
STAGE_HEIGHT = 320

-- START:tileSizes
-- Tile properties
TILE_WIDTH = 40
TILE_HEIGHT = 40
-- END:tileSizes

-- START:walkTypes
-- Tile types (for building and pathfinding)
TILE_WALK = 1
TILE_BUIL = -1
TILE_EMPTY = 0
-- START:walkTypes

-- START:imageNames
IMG_GOLD = "currency"
IMG_TOWER = "tower"
-- END:imageNames
-- START:livesIcon
IMG_LIVES = "heart"
-- END:livesIcon

-- The cost to build 1 tower
TOWER_COST = 1

-- START:levelDifficultyParams
-- How much the difficulty increases for each block of levels
-- Parameters: number of creeps, health
gameDifficultyIncrease = { creepMultiplier = 1.5, healthCoeff = 2 }
-- END:levelDifficultyParams

-- START:enemyImage
-- Enemy image
IMG_ENEMY = "creep1"
-- Starting coordinates
spawnCoordinates = { x = TILE_WIDTH * 1.5, y = TILE_HEIGHT * 0.5 }
endTile = { x = 10, y = 1 }
-- END:enemyImage

-- START:enemyParams
-- Enemy sprite state params
DELETE_OOB = true
DELETE_DEAD = true
DO_NOT_DELETE = false
-- END:enemyParams

-- START:healthBarSize
-- Health bar sizes
HEALTH_BAR_WIDTH = 40
HEALTH_BAR_HEIGHT = 4
-- END:healthBarSize

