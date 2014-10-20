-- Load the sprite images
local sheetInfo = require( "walking" )

-- Create the image sheet
local imageSheet = graphics.newImageSheet( "myImageSheet.png", 
    sheetInfo:getSheet( ) )
    
-- START:sequenceData
-- A sequenceData variable for our walking character
local sequenceData = {
    -- Sequence 1
    {
        name = "static",
        start = sheetInfo:getFrameIndex( "walk_sprite0002" ),
        count = 1
    },
    -- Sequence 2
    {
        name = "moving",
        start = sheetInfo:getFrameIndex( "walk_sprite0001" ),
        time = 400,
        count = 4
    }
}
-- END:sequenceData

-- Add a sprite using newSprite
local mySprite = display.newSprite( imageSheet, sequenceData )

-- START:playSequence
-- Set the walking animation
mySprite:setSequence( "moving" )
mySprite:play( )

-- Set its position
mySprite.x = 160
mySprite.y = 200
-- END:playSequence
