--
-- created with TexturePacker (http://www.texturepacker.com)
--
-- $TexturePacker:SmartUpdate:86bcaeb31515e238420f0929b5310711$
--
-- local sheetInfo = require("myExportedImageSheet") -- lua file that Texture packer published
--
-- local myImageSheet = graphics.newImageSheet( "ImageSheet.png", sheetInfo:getSheet() ) -- ImageSheet.png is the image Texture packer published
--
-- local myImage1 = display.newImage( myImageSheet , sheetInfo:getFrameIndex("image_name1"))
-- local myImage2 = display.newImage( myImageSheet , sheetInfo:getFrameIndex("image_name2"))
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- ball
            x=328,
            y=54,
            width=50,
            height=50,

        },
        {
            -- crate1
            x=432,
            y=2,
            width=50,
            height=50,

        },
        {
            -- crate2
            x=380,
            y=2,
            width=50,
            height=50,

        },
        {
            -- crate3
            x=328,
            y=2,
            width=50,
            height=50,

        },
        {
            -- wall_bottom
            x=106,
            y=48,
            width=220,
            height=44,

        },
        {
            -- wall_left
            x=54,
            y=2,
            width=50,
            height=480,

        },
        {
            -- wall_right
            x=2,
            y=2,
            width=50,
            height=480,

        },
        {
            -- wall_top
            x=106,
            y=2,
            width=220,
            height=44,

        },
    },
    
    sheetContentWidth = 512,
    sheetContentHeight = 512
}

SheetInfo.frameIndex =
{

    ["ball"] = 1,
    ["crate1"] = 2,
    ["crate2"] = 3,
    ["crate3"] = 4,
    ["wall_bottom"] = 5,
    ["wall_left"] = 6,
    ["wall_right"] = 7,
    ["wall_top"] = 8,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
