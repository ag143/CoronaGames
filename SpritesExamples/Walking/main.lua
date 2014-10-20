-- START:spriteOptions
local spriteOptions = {
    -- Define the number of frames and image sizes
    numFrames = 4,
    width = 157,
    height = 160
}

-- Create the image sheet
local imageSheet = graphics.newImageSheet( "myImageSheet.png", 
    spriteOptions )
-- END:spriteOptions
    
-- START:addNewSprite
-- Define the sprite's sequence data
--   (the frames and animations we'll work with)
local sequenceData = {
    -- Set the name, a starting frame, and the number of frames
    name = "walking",
    start = 1,
    count = 4,
    time = 800
}
-- Add a sprite using newSprite
local mySprite = display.newSprite( imageSheet, sequenceData )

-- Set the walking animation
mySprite:setSequence( "walking" )
mySprite:play( )

-- Set its position
mySprite.x = 160
mySprite.y = 200
-- END:addNewSprite
