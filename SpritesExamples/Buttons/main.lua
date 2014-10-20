-- START:simpleImages
-- Store the options to use images of constant size
local spriteOptions = {
    -- Define the number of frames and image sizes
    numFrames = 2,
    width = 80,
    height = 40
}

-- Create the image sheet and display the first image
local imageSheet = graphics.newImageSheet( "myImageSheet.png", 
    spriteOptions )
local myImage = display.newImage( imageSheet, 1 )
-- END:simpleImages

-- START:displayImagesButtons

-- Set its x and y coordinates
myImage.x = 160
myImage.y = 240
-- END:displayImagesButtons
