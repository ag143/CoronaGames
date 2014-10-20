local spriteOptions = {
    -- Define the number of frames and image sizes
    numFrames = 4,
    width = 157,
    height = 160,
}

-- Create the image sheet
local imageSheet = graphics.newImageSheet( "myImageSheet.png", 
    spriteOptions )
    
-- START:nonConsecutiveFrames
-- Define an animation sequence using non-consecutive frames
local sequenceData = {
    -- Set the name and frames in the animation
    name = "walking",
    frames = { 1, 3 },
    time = 600
}
-- Add a sprite using newSprite
local mySprite = display.newSprite( imageSheet, sequenceData )
-- Set the walking animation
mySprite:setSequence( "walking" )
mySprite:play( )
-- END:nonConsecutiveFrames

-- START:playNonConsecutive
-- Set its position
mySprite.x = 160
mySprite.y = 200
-- END:playNonConsecutive
