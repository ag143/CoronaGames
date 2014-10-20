--
-- created with TexturePacker (http://www.texturepacker.com)
--
-- $TexturePacker:SmartUpdate:5bb06fd024c776b69d83ac0428c9e363$
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
            -- asteroid_1
            x=2,
            y=142,
            width=80,
            height=76,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 80,
            sourceHeight = 80
        },
        {
            -- asteroid_2
            x=2,
            y=60,
            width=80,
            height=80,

        },
        {
            -- asteroid_3
            x=84,
            y=60,
            width=74,
            height=74,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 80,
            sourceHeight = 80
        },
        {
            -- crater_1
            x=86,
            y=238,
            width=16,
            height=16,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 80,
            sourceHeight = 80
        },
        {
            -- crater_2
            x=66,
            y=238,
            width=18,
            height=16,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 80,
            sourceHeight = 80
        },
        {
            -- crater_3
            x=104,
            y=238,
            width=16,
            height=14,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 80,
            sourceHeight = 80
        },
        {
            -- crater_4
            x=26,
            y=220,
            width=18,
            height=20,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 80,
            sourceHeight = 80
        },
        {
            -- crater_5
            x=66,
            y=220,
            width=18,
            height=16,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 80,
            sourceHeight = 80
        },
        {
            -- enemy1
            x=160,
            y=60,
            width=82,
            height=56,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 85,
            sourceHeight = 60
        },
        {
            -- enemy2
            x=170,
            y=2,
            width=82,
            height=56,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 85,
            sourceHeight = 60
        },
        {
            -- enemy3
            x=86,
            y=2,
            width=82,
            height=56,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 85,
            sourceHeight = 60
        },
        {
            -- enemy_bullet
            x=14,
            y=220,
            width=10,
            height=34,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 10,
            sourceHeight = 33
        },
        {
            -- health_powerup
            x=46,
            y=220,
            width=18,
            height=18,

        },
        {
            -- player
            x=2,
            y=2,
            width=82,
            height=56,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 85,
            sourceHeight = 60
        },
        {
            -- player_bullet
            x=2,
            y=220,
            width=10,
            height=34,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 10,
            sourceHeight = 33
        },
        {
            -- player_l
            x=86,
            y=178,
            width=78,
            height=58,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 85,
            sourceHeight = 60
        },
        {
            -- player_life
            x=46,
            y=240,
            width=18,
            height=14,

            sourceX = 0,
            sourceY = 2,
            sourceWidth = 18,
            sourceHeight = 18
        },
        {
            -- player_r
            x=160,
            y=118,
            width=78,
            height=58,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 85,
            sourceHeight = 60
        },
    },
    
    sheetContentWidth = 256,
    sheetContentHeight = 256
}

SheetInfo.frameIndex =
{

    ["asteroid_1"] = 1,
    ["asteroid_2"] = 2,
    ["asteroid_3"] = 3,
    ["crater_1"] = 4,
    ["crater_2"] = 5,
    ["crater_3"] = 6,
    ["crater_4"] = 7,
    ["crater_5"] = 8,
    ["enemy1"] = 9,
    ["enemy2"] = 10,
    ["enemy3"] = 11,
    ["enemy_bullet"] = 12,
    ["health_powerup"] = 13,
    ["player"] = 14,
    ["player_bullet"] = 15,
    ["player_l"] = 16,
    ["player_life"] = 17,
    ["player_r"] = 18,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
