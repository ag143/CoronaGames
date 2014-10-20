-- Includes
require "globals"

-- START:tileMap
-- tile map
map = { 
    { 10, 22, 9, 4, 2, 1, 5, 1, 10, 22, 9, 1 },
    { 10, 22, 9, 5, 2, 1, 1, 2, 10, 22, 11, 16 }, 
    { 10, 22, 9, 1, 5, 1, 3, 2, 10, 22, 22, 9 }, 
    { 10, 22, 11, 12, 12, 12, 16, 2, 15, 8, 22, 9 },
    { 10, 22, 22, 22, 22, 22, 9, 1, 1, 10, 22, 9 },
    { 15, 7, 7, 7, 8, 22, 11, 12, 12, 13, 22, 9 },
    { 5, 2, 1, 1, 10, 22, 22, 22, 22, 22, 22, 9 },
    { 5, 1, 3, 5, 15, 7, 7, 7, 7, 7, 7, 14 }
}
mapWidth = #map[1]
mapHeight = #map
-- END:tileMap

-- START:walkableTiles
-- Stores whether the tiles in tiles.png are walkable 
-- or if they can be used to build towers
tileProperties = {
    { TILE_BUIL, TILE_BUIL, TILE_BUIL, TILE_BUIL, TILE_BUIL },
    { TILE_EMPTY, TILE_EMPTY, TILE_EMPTY, TILE_EMPTY, TILE_EMPTY },
    { TILE_EMPTY, TILE_EMPTY, TILE_EMPTY, TILE_BUIL, TILE_BUIL },
    { TILE_BUIL, TILE_BUIL, TILE_EMPTY, TILE_EMPTY, TILE_EMPTY },
    { TILE_BUIL, TILE_WALK, TILE_EMPTY, TILE_EMPTY, TILE_EMPTY },
    { TILE_EMPTY, TILE_EMPTY, TILE_EMPTY, TILE_EMPTY, TILE_BUIL },
    { TILE_EMPTY, TILE_EMPTY, TILE_BUIL, TILE_BUIL, TILE_BUIL }
}
-- END:walkableTiles

-- START:tileSpriteSet
-- Load the tiles and create a new sprite sheet and set
local options = 
{
    width = TILE_WIDTH,
    height = TILE_HEIGHT,
    numFrames = 35,
}
local tileSpriteSheet = graphics.newImageSheet( "images/tiles.png", options )
-- local tileSpriteSheet = sprite.newSpriteSheet( "tiles.png", TILE_WIDTH, TILE_HEIGHT )
-- local tileSpriteSet = sprite.newSpriteSet( tileSpriteSheet, 1, 30 )
-- END:tileSpriteSet

-- START:drawMap
-- Adds the tile map to a group
function drawMap( where )
    for j = 1, #map do
        for i = 1, #( map[j] ) do
            -- Create a new tile image for each table element 
            -- and place it in the right position and frame
            local tempImage = display.newImage( tileSpriteSheet, map[j][i] )
            tempImage.x = i * TILE_WIDTH - TILE_WIDTH / 2
            tempImage.y = j * TILE_HEIGHT - TILE_HEIGHT / 2
            
            -- Add the sprite to the group
            where:insert( tempImage )
            -- END:drawMap
            -- Uncomment this to draw rectangles over buildable tiles
            -- drawIfWalkable( where, i, j )
            -- START:drawMap
        end
    end
end
-- END:drawMap

function getWalkableType( tileType )
    local col = 1 + (tileType - 1) % 5
    local row = math.ceil( (tileType) / 5 )
    return tileProperties[row][col]
end

-- Draw a rectangle if the tile can be used to build towers
function drawIfWalkable( where, i, j)
    if ( getWalkableType( map[j][i] ) == TILE_BUIL ) then
        local newRectangle = display.newRect( (i - 1) * TILE_WIDTH, 
            (j - 1) * TILE_HEIGHT, TILE_WIDTH, TILE_HEIGHT )
        newRectangle:setFillColor( 50/255, 50/255, 100/255 )
        newRectangle.strokeWidth = 1
        newRectangle:setStrokeColor( 1, 0, 0 )
        newRectangle.alpha = 0.5
        where:insert( newRectangle )
    end
end