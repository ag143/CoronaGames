-- START:loadSheet
-- Load the sprite images
local sheetInfo = require( "walking" )

-- Create the image sheet
local imageSheet = graphics.newImageSheet( "myImageSheet.png", 
    sheetInfo:getSheet( ) )
-- END:loadSheet
    
-- START:consecutiveFrames
-- Define an animation sequence using TexturePacker files
local sequenceData = {
    -- Set the name, a starting frame, and the number of frames
    name = "walking",
    start = sheetInfo:getFrameIndex( "walk_sprite0001" ),
    time = 600,
    count = 4
}
-- Add a sprite using newSprite
local mySprite = display.newSprite( imageSheet, sequenceData )
-- Set the walking animation
mySprite:setSequence( "walking" )
mySprite:play( )
-- END:consecutiveFrames

-- Set its position
mySprite.x = 160
mySprite.y = 200
