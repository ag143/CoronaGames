-- START:complexImages
-- Store the options for two different images
local spriteOptions = { 
-- array of tables representing each frame (required)
frames =
{
    -- Store the image sizes in a frames list
    frames = 
        {
            name = "smile",
            x = 0,
            y = 0,
            width = 32,
            height = 32
        },
        {
            name = "frown",
            x = 32,
            y = 0,
            width = 32,
            height = 32
        },
    },
}
-- Create the image sheet
local complexImageSheet = graphics.newImageSheet( "myImageSheet.png", 
    spriteOptions )
-- END:complexImages

-- START:createImage
-- Display the image on the left of our image sheet
local myImage = display.newImage( complexImageSheet, 1 )
-- Set its position
myImage.x = 160
myImage.y = 100
-- END:createImage

-- START:createImageRect
-- Get a 16x16 smiley face using newImageRect 
--    so that proper resolutions are picked depending on the device
local topLeftImage = display.newImageRect( complexImageSheet, 1, 16, 16 )

-- Set its position
topLeftImage.x = 160
topLeftImage.y = 130
-- END:createImageRect

-- START:addImageToGroup
-- Create a new group and insert myImage
local myGroup = display.newGroup( )
myGroup:insert( myImage )
-- END:addImageToGroup