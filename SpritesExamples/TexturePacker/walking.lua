--
-- created with TexturePacker (http://www.texturepacker.com)
--
-- $TexturePacker:SmartUpdate:21fccccaa1078fb4ef13a9aa00541a33$
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
            -- walk_sprite0001
            x=2,
            y=106,
            width=50,
            height=112,

            sourceX = 52,
            sourceY = 32,
            sourceWidth = 157,
            sourceHeight = 160
        },
        {
            -- walk_sprite0002
            x=70,
            y=2,
            width=52,
            height=112,

            sourceX = 54,
            sourceY = 36,
            sourceWidth = 157,
            sourceHeight = 160
        },
        {
            -- walk_sprite0003
            x=54,
            y=116,
            width=36,
            height=106,

            sourceX = 58,
            sourceY = 34,
            sourceWidth = 157,
            sourceHeight = 160
        },
        {
            -- walk_sprite0004
            x=2,
            y=2,
            width=66,
            height=102,

            sourceX = 44,
            sourceY = 36,
            sourceWidth = 157,
            sourceHeight = 160
        },
    },
    
    sheetContentWidth = 128,
    sheetContentHeight = 256
}

SheetInfo.frameIndex =
{

    ["walk_sprite0001"] = 1,
    ["walk_sprite0002"] = 2,
    ["walk_sprite0003"] = 3,
    ["walk_sprite0004"] = 4,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
