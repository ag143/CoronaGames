-- START:spriteOptions
-- Define the number of frames and image sizes
local spriteOptions = {
    numFrames = 4,
    width = 157,
    height = 160,
}

-- Create the image sheet
local imageSheet = graphics.newImageSheet( "myImageSheet.png", 
    spriteOptions )
-- END:spriteOptions
    
-- START:multipleAnims
-- Define multiple animations
local sequenceData = {
    -- Sequence 1
    {
        name = "static",
        start = 1,
        count = 1
    },
    -- Sequence 2
    {
        name = "moving",
        frames = { 1, 2, 3, 4 },
        time = 800
    }
}
-- Add a sprite using newSprite
local mySprite = display.newSprite( imageSheet, sequenceData )
-- END:multipleAnims

-- START:setAnim
-- Set the walking animation
mySprite:setSequence( "moving" )
mySprite:play( )
-- Set its position
mySprite.x = 160
mySprite.y = 200
-- END:setAnim
