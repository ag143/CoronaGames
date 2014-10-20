--
-- created with TexturePacker (http://www.texturepacker.com)
--
-- $TexturePacker:SmartUpdate:41df84216ac9c5cd14465dfaa53a5f83$
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
            -- creep1
            x=2,
            y=2,
            width=82,
            height=56,

            sourceX = 2,
            sourceY = 4,
            sourceWidth = 85,
            sourceHeight = 60
        },
        {
            -- currency
            x=2,
            y=98,
            width=18,
            height=18,

        },
        {
            -- heart
            x=2,
            y=78,
            width=18,
            height=18,

        },
        {
            -- tower
            x=86,
            y=2,
            width=40,
            height=74,

            sourceX = 0,
            sourceY = 6,
            sourceWidth = 40,
            sourceHeight = 80
        },
    },
    
    sheetContentWidth = 128,
    sheetContentHeight = 128
}

SheetInfo.frameIndex =
{

    ["creep1"] = 1,
    ["currency"] = 2,
    ["heart"] = 3,
    ["tower"] = 4,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
